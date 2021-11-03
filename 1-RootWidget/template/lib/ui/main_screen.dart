import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
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
    pageList.add(const ProjectFeedScreen());
    pageList.add(const ProfileScreen());
    pageList.add(Container(color: Colors.green));
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

  // @override
  // Widget build(BuildContext context) {
  //   String title;
  //   switch (_selectedIndex) {
  //     case 0:
  //       title = 'Gember';
  //       break;
  //     case 1:
  //       title = 'Priorities';
  //       break;
  //     case 2:
  //       title = 'Account';
  //       break;
  //     default:
  //       title = 'Gember';
  //       break;
  //   }
  //   return Scaffold(
  //     bottomNavigationBar: BottomNavigationBar(
  //       items: [
  //         BottomNavigationBarItem(
  //             icon: SvgPicture.asset('assets/images/icon_recipe.svg',
  //                 color: _selectedIndex == 0 ? green : Colors.grey,
  //                 semanticsLabel: 'Gember'),
  //             label: 'Gember'),
  //         BottomNavigationBarItem(
  //             icon: SvgPicture.asset('assets/images/icon_bookmarks.svg',
  //                 color: _selectedIndex == 1 ? green : Colors.grey,
  //                 semanticsLabel: 'Priorities'),
  //             label: 'Priorities'),
  //         BottomNavigationBarItem(
  //             icon: SvgPicture.asset('assets/images/icon_shopping_list.svg',
  //                 color: _selectedIndex == 2 ? green : Colors.grey,
  //                 semanticsLabel: 'Account'),
  //             label: 'Account'),
  //       ],
  //       currentIndex: _selectedIndex,
  //       selectedItemColor: green,
  //       onTap: _onItemTapped,
  //     ),
  //     appBar: AppBar(
  //       elevation: 0,
  //       backgroundColor: Colors.white,
  //       systemOverlayStyle: const SystemUiOverlayStyle(
  //         systemNavigationBarColor: Colors.white,
  //         statusBarColor: Colors.white,
  //         statusBarBrightness: Brightness.light,
  //         statusBarIconBrightness: Brightness.dark,
  //         systemNavigationBarDividerColor: Colors.white,
  //         //Navigation bar divider color
  //         systemNavigationBarIconBrightness:
  //             Brightness.light, //navigation bar icon
  //       ),
  //       title: Text(
  //         title,
  //         style: const TextStyle(
  //             fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
  //       ),
  //     ),
  //     body: IndexedStack(
  //       index: _selectedIndex,
  //       children: pageList,
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateManager>(
      builder: (context, appStateManager, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Gember',
              style: Theme.of(context).textTheme.headline6,
            ),
            actions: [
              profileButton(),
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
              const BottomNavigationBarItem(
                icon: Icon(Icons.explore),
                label: 'Explore',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.book),
                label: 'Profile',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'To Buy',
              ),
            ],
          ),
        );
      },
    );
  }

  Widget profileButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: GestureDetector(
        child: const CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage(
            'assets/profile_pics/person_stef.jpeg',
          ),
        ),
        onTap: () {
          // Provider.of<ConsumerManager>(context, listen: false)
          //     .tapOnOwnProfile(true);
          // TODO: Dont hard code the following
          Provider.of<AppStateManager>(context, listen: false).goToTab(2);
        },
      ),
    );
  }
}
