import 'package:flutter/material.dart';
import '../models/models.dart';

class ProfileScreen extends StatelessWidget {
  static MaterialPage page() {
    return MaterialPage(
      name: TemplatePages.projectFeedPath,
      key: ValueKey(TemplatePages.projectFeedPath),
      child: const ProfileScreen(),
    );
  }

  final String? username;

  const ProfileScreen({
    Key? key,
    this.username,
  }) : super(key: key);

  final Color rwColor = const Color.fromRGBO(64, 143, 77, 1);
  final TextStyle focusedStyle = const TextStyle(color: Colors.green);
  final TextStyle unfocusedStyle = const TextStyle(color: Colors.grey);

  @override
  Widget build(BuildContext context) {
    //TODO: Use the my_recipe_list.dart to build a stream of Priorites cards that the app listens to updates for.
    return Container(color: Colors.red);
  }
}
