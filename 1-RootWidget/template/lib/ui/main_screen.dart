import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:template/data/user_dao.dart';
import 'package:template/ui/models/consumer_manager.dart';
import 'package:template/ui/screens/screens.dart';
import 'colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';

import 'models/app_state_manager.dart';
import 'models/template_pages.dart';
import 'screens/home.dart';

class MainScreen extends StatefulWidget {
  static MaterialPage page(int currentTab) {
    // return MaterialPage(
    //   name: TemplatePages.home,
    //   key: ValueKey(TemplatePages.home),
    //   child: Home(
    //     currentTab: currentTab,
    //   ),
    // );
    return MaterialPage(
      name: TemplatePages.home,
      key: ValueKey(TemplatePages.home),
      child: MainScreen(currentTab: currentTab),
    );
  }

  const MainScreen({
    Key? key,
    required this.currentTab,
  }) : super(key: key);

  final int currentTab;

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  List<Widget> pageList = <Widget>[];
  static const String prefSelectedIndexKey = 'selectedIndex';

  @override
  void initState() {
    super.initState();
    pageList.addAll(AppStateManager.screenMap.values);
    // pageList.add(const ProjectFeedScreen());
    // pageList.add(const ProfileScreen());
    // pageList.add(const AddProjectScreen());
    getCurrentIndex();
  }

  void saveCurrentIndex() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(prefSelectedIndexKey, _selectedIndex);
  }

  void getCurrentIndex() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(prefSelectedIndexKey)) {
      setState(() {
        final index = prefs.getInt(prefSelectedIndexKey);
        if (index != null) {
          _selectedIndex = index;
        }
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    saveCurrentIndex();
  }

  @override
  Widget build(BuildContext context) {
    final userDao = Provider.of<UserDao>(context, listen: true);
    return Consumer<AppStateManager>(
      builder: (context, appStateManager, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              appStateManager.currentScreenName,
              style: Theme.of(context).textTheme.headline6,
            ),
            actions: [
              profileButton(context, userDao),
            ],
            
          ),

          body: IndexedStack(index: widget.currentTab, children: pageList),
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor:
                Theme.of(context).textSelectionTheme.selectionColor,
            currentIndex: widget.currentTab,
            onTap: (index) {
              Provider.of<AppStateManager>(context, listen: false)
                  .goToTab(index);
            },
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.explore),
                label: appStateManager.getScreenName(0),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.book),
                label: appStateManager.getScreenName(1),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: appStateManager.getScreenName(2),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.lightbulb_outline),
                label: appStateManager.getScreenName(3),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: appStateManager.getScreenName(4),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget profileButton(BuildContext context, UserDao userDao) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: GestureDetector(
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: NetworkImage(userDao.profilePicture),
        ),
        onTap: () {
          // Provider.of<ConsumerManager>(context, listen: false)
          //     .tapOnOwnProfile(true);
          // TODO: Dont hard code the following
          Provider.of<AppStateManager>(context, listen: false).goToAccounts();
          // _showActionSheet(context);
        },
      ),
    );
  }

  void _showActionSheet(BuildContext context) {
    if (Platform.isIOS) {
      showCupertinoModalPopup(
          context: context,
          builder: (context) {
            return CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                    onPressed: () {
                      Navigator.pop(context);
                      Provider.of<AppStateManager>(context, listen: false)
                          .logout();
                    },
                    child: const Text('Logout')),
                // CupertinoActionSheetAction(
                //     onPressed: _updateProfilePictureFromWebLink,
                //     child: Text(actions[2]))
              ],
            );
          });
    } else {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
                height: 150,
                child: Column(children: <Widget>[
                  ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        Provider.of<UserDao>(context, listen: false).logout();
                      },
                      leading: const Icon(Icons.logout_outlined),
                      title: const Text('Logout'))
                ]));
          });
    }
  }
}
