import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/ui/components/card_tappable.dart';
import 'package:template/ui/components/project_contents.dart';
import '../components/card1.dart';
import '../models/consumer_manager.dart';
import 'package:uuid/uuid.dart';
import '../models/models.dart';

class ProfileScreen extends StatefulWidget {
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

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Color rwColor = const Color.fromRGBO(64, 143, 77, 1);

  final TextStyle focusedStyle = const TextStyle(color: Colors.green);

  final TextStyle unfocusedStyle = const TextStyle(color: Colors.grey);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        top: false,
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: [
              SizedBox(
                height: 100,
                child: _buildSocialProfileHeader(),
              ),
              const SizedBox(height: 8.0),
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            return CardTappable(
                                child: ProjectContents(
                              project: GreenProject(
                                  uid: Uuid().v4(),
                                  name: '<Green Project>',
                                  company_name: '<Company Name>',
                                  description: 'Some Desc',
                                  short_description: 'Shorty',
                                  image_url:
                                      'https://th.bing.com/th/id/OIP.D9fLXBRbRjJtc2cgORlbKAHaE7?w=251&h=180&c=7&r=0&o=5&pid=1.7'),
                            ));
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 8.0,
                            );
                          },
                          itemCount: 3))
              )
            ],
          ),
        ),
        // Column(children: [
        //   SizedBox(
        //     width: 350,
        //     height: 100,
        //     child:
        //       Stack(children: <Widget>[
        //         Container(
        //           padding: EdgeInsets.all(0.0),
        //           decoration: BoxDecoration(
        //               image: DecorationImage(
        //                   image: AssetImage('assets/images/cover_photo.jpeg'),
        //                 fit: BoxFit.cover)),
        //         ),
        //         Container(
        //           padding: const EdgeInsets.only(right: 16.0),
        //           alignment: Alignment.bottomCenter,
        //           child: GestureDetector(
        //             child: const CircleAvatar(
        //               backgroundColor: Colors.transparent,
        //               backgroundImage: AssetImage(
        //                 'assets/profile_pics/person_stef.jpeg',
        //               ),
        //             ),
        //             onTap: () {
        //               Provider.of<ConsumerManager>(context, listen: false)
        //                   .consumerTapped(1);
        //             },
        //           ),
        //         )
        //       ]),
        //     ),
        //   // const SizedBox(
        //   //   height: 8.0,
        //   // ),
        //   // ListView.separated(
        //   //     itemBuilder: (context, index) {
        //   //       return Card1(
        //   //         project: GreenProject(
        //   //             uid: Uuid().v4(),
        //   //             name: '<Green Project>',
        //   //             company_name: '<Company Name>',
        //   //             description: 'Some Desc',
        //   //             short_description: 'Shorty',
        //   //             image_url:
        //   //                 'https://th.bing.com/th/id/OIP.UH6LYvkPAlcpR5z5UCT66wHaE7?w=274&h=182&c=7&r=0&o=5&pid=1.7'),
        //   //       );
        //   //     },
        //   //     separatorBuilder: (context, index) {
        //   //       return SizedBox(
        //   //         height: 8.0,
        //   //       );
        //   //     },
        //   //     itemCount: 3)
        // ]),
      ),
    );
  }

  Widget _buildSocialProfileHeader() {
    final avatarHeight = 60.0;
    final coverPhotoBottom = avatarHeight * 0.33;
    return Stack(children: [
      Container(
        padding: EdgeInsets.all(0.0),
        margin: EdgeInsets.only(bottom: coverPhotoBottom),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/cover_photo.jpeg'),
                fit: BoxFit.cover)),
      ),
      Container(
          alignment: Alignment.bottomCenter,
          child: CircleAvatar(
            radius: avatarHeight * 0.5,
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage('assets/profile_pics/person_stef.jpeg'),
          ))
    ]);
  }
}
