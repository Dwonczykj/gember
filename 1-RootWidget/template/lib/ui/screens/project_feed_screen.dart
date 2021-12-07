import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chopper/chopper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:template/data/project_dao.dart';
import 'package:template/network/model_response.dart';
import 'package:template/network/service_interface.dart';
import 'package:template/network/template_service.dart';
import 'package:template/ui/components/project_card.dart';
import '../models/models.dart';
import '../components/card1.dart';

class ProjectFeedScreen extends StatefulWidget {
  // static MaterialPage page() {
  //   return MaterialPage(
  //     name: TemplatePages.projectFeedPath,
  //     key: ValueKey(TemplatePages.projectFeedPath),
  //     child: const ProjectFeedScreen(),
  //   );
  // }

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

  List<GreenProject> currentSearchList = [];

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
    final widget = StreamBuilder<Iterable<GreenProject>>(
      stream: Provider.of<ProjectDao>(context).getProjectsStream(),
      builder: (context, snapshot) {
        if (true) {
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
          final result = snapshot.data;

          // Hit an error
          if (result is Error) {
            inErrorState = true;
            return _buildProjectList(context, <GreenProject>[]);
          }
          // final query = (result as Success).value;
          final query = snapshot.data;
          inErrorState = false;
          if (query != null) {
            currentCount = query.length;
            // hasMore = query.more;
            currentSearchList.clear();
            currentSearchList.addAll(query);
            // if (query.to < currentEndPosition) {
            //   currentEndPosition = query.to;
            // }

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

    return widget;
  }

  Widget _buildProjectList(
      BuildContext context, List<GreenProject> projectList) {
    // final List<String> entries = <String>['A', 'B', 'C'];
    // final List<int> colorCodes = <int>[600, 500, 100];

    final size = MediaQuery.of(context).size;
    // const itemHeight = 310;
    // final itemWidth = size.width / 1;

    return ListView.separated(
        itemBuilder: (context, index) {
          return Card1(
            project: projectList[index],
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 8.0,
          );
        },
        itemCount: projectList.length);
  }

  Widget _buildProjectCard(BuildContext context, GreenProject project) {
    return ProjectCard(project: project);
  }
}
