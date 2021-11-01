import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/models.dart';
import 'card1.dart';

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
    return Column(children: [
      SafeArea(
          child: Container(
        padding: EdgeInsets.all(0.0),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/cover_photo.jpeg'),
                fit: BoxFit.cover)),
      )),
      ListView.separated(
          itemBuilder: (context, index) {
            return Card1(
              project: GreenProject(
                  uid: Uuid().v4(),
                  name: '<Green Project>',
                  company_name: '<Company Name>',
                  description: 'Some Desc',
                  short_description: 'Shorty',
                  image_url:
                      'https://th.bing.com/th/id/OIP.UH6LYvkPAlcpR5z5UCT66wHaE7?w=274&h=182&c=7&r=0&o=5&pid=1.7'),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 8.0,
            );
          },
          itemCount: 3)
    ]);
  }
}
