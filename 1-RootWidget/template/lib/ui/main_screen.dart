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
    pageList.add(const AddProjectScreen()); 
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
    return Consumer<AppStateManager>(
      builder: (context, appStateManager, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              appStateManager.currentScreenName,
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
