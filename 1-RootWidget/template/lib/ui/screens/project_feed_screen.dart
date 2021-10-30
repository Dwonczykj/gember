import 'dart:math';

import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:template/network/model_response.dart';
import 'package:template/network/service_interface.dart';
import 'package:template/network/template_service.dart';
import 'package:template/ui/components/project_card.dart';
import '../models/models.dart';

class ProjectFeedScreen extends StatefulWidget {
  static MaterialPage page() {
    return MaterialPage(
      name: TemplatePages.projectFeedPath,
      key: ValueKey(TemplatePages.projectFeedPath),
      child: const ProjectFeedScreen(),
    );
  }

  final String? username;

  const ProjectFeedScreen({
    Key? key,
    this.username,
  }) : super(key: key);

  @override
  State<ProjectFeedScreen> createState() => _ProjectFeedScreenState();
}

class _ProjectFeedScreenState extends State<ProjectFeedScreen> {
  late TextEditingController searchTextController;

  final ScrollController _scrollController = ScrollController();

  static const String prefSearchKey = 'previousSearches';

  List<Project> currentSearchList = [];

  int currentCount = 0;

  int currentStartPosition = 0;

  int currentEndPosition = 20;

  int pageCount = 20;

  bool hasMore = false;

  bool loading = false;

  bool inErrorState = false;

  List<String> previousSearches = <String>[];

  @override
  void initState() {
    super.initState();
    getPreviousSearches();

    searchTextController = TextEditingController(text: '');
    _scrollController
      ..addListener(() {
        final triggerFetchMoreSize =
            0.7 * _scrollController.position.maxScrollExtent;

        if (_scrollController.position.pixels > triggerFetchMoreSize) {
          if (hasMore &&
              currentEndPosition < currentCount &&
              !loading &&
              !inErrorState) {
            setState(() {
              loading = true;
              currentStartPosition = currentEndPosition;
              currentEndPosition =
                  min(currentStartPosition + pageCount, currentCount);
            });
          }
        }
      });
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  void savePreviousSearches() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(prefSearchKey, previousSearches);
  }

  void getPreviousSearches() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(prefSearchKey)) {
      final searches = prefs.getStringList(prefSearchKey);
      if (searches != null) {
        previousSearches = searches;
      } else {
        previousSearches = <String>[];
      }
    }
  }

  final Color rwColor = const Color.fromRGBO(64, 143, 77, 1);

  final TextStyle focusedStyle = const TextStyle(color: Colors.green);

  final TextStyle unfocusedStyle = const TextStyle(color: Colors.grey);

  @override
  Widget build(BuildContext context) {
    // TODO: Build Project Feed with ListView of Cards, see recipe_list.dart
    return FutureBuilder<Response<Result<List<Project>>>>(
      future: Provider.of<ServiceInterface>(context)
          .queryProjects(searchTextController.text.trim()),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                textAlign: TextAlign.center,
                textScaleFactor: 1.3,
              ),
            );
          }

          loading = false;
          final result = snapshot.data?.body;
          // Hit an error
          if (result is Error) {
            inErrorState = true;
            return _buildProjectList(context, currentSearchList);
          }
          final query = (result as Success).value;
          inErrorState = false;
          if (query != null) {
            currentCount = query.count;
            hasMore = query.more;
            currentSearchList.addAll(query.hits);
            if (query.to < currentEndPosition) {
              currentEndPosition = query.to;
            }
          }
          return _buildProjectList(context, currentSearchList);
        } else {
          if (currentCount == 0) {
            // Show a loading indicator while waiting for the movies
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return _buildProjectList(context, currentSearchList);
          }
        }
      },
    );
  }

  Widget _buildProjectList(
      BuildContext context, List<Project> currentSearchList) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Projects',
            style: Theme.of(context).textTheme.headline1,
          ),
          const SizedBox(height: 16),
          Container(
            height: 400,
            color: Colors.transparent,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: currentSearchList.length,
              itemBuilder: (context, index) {
                final project = currentSearchList[index];
                return _buildProjectCard(context, project);
              },
              separatorBuilder: (context, index) {
                return const SizedBox(width: 16);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(BuildContext context, Project project) {
    return ProjectCard(project: project);
  }
}
