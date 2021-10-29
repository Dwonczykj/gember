import 'package:flutter/material.dart';
import 'package:template/ui/components/ProjectCard.dart';
import '../models/models.dart';

class ProjectFeedScreen extends StatelessWidget {
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

  final Color rwColor = const Color.fromRGBO(64, 143, 77, 1);
  final TextStyle focusedStyle = const TextStyle(color: Colors.green);
  final TextStyle unfocusedStyle = const TextStyle(color: Colors.grey);

  @override
  Widget build(BuildContext context) {
    // TODO: Build Project Feed with ListView of Cards, see recipe_list.dart
    return Container(color: Colors.red);
  }

  Widget buildProjectCard(BuildContext context) {
    //TODO: CHeck out the RecipeCard.dart stuff to build this and add a ProjectCard.dart Component to ui/Components
    return ProjectCard();
  }
}
