import 'dart:async';
import 'package:flutter/material.dart';
import 'package:template/data/user_dao.dart';
import 'package:template/fooderlich_theme.dart';
import 'package:template/ui/screens/add_media_screen.dart';
import 'package:template/ui/screens/edit_my_profile_screen.dart';
import 'package:template/ui/screens/screens.dart';
import 'package:template/ui/screens/test_screen.dart';
import 'package:template/ui/screens/view_my_profile_screen.dart';

// 1
class GemberTab {
  static final _smL = AppStateManager.screenMap.keys.toList();
  static final int explore = _smL.indexOf('Explore');
  static final int profile = _smL.indexOf('Profile');
  static final int promote = _smL.indexOf('Promote');
  static final int test = _smL.indexOf('Test');
  static final int account = _smL.indexOf('Account');
}

// Map<String, Widget> screenMap = <String, Widget>{
//   'Explore': const ProjectFeedScreen(),
//   'Profile': const ProfileScreen(),
//   'Promote': const AddProjectScreen(),
//   'Account': ViewMyProfileScreen(), // const TestScreen(),
// };

class AppStateManager extends UserDao {
  // 2
  bool _initialized = false;

  // 4
  bool _onboardingComplete = false;
  // 5
  int _selectedTab = GemberTab.explore;

  // 6
  bool get isInitialized => _initialized;

  bool get isOnboardingComplete => _onboardingComplete;
  int get getSelectedTab => _selectedTab;
  String get currentScreenName => _tabNames[_selectedTab];
  static Map<String, Widget> screenMap = <String, Widget>{
    'Explore': const ProjectFeedScreen(),
    'Profile': const ProfileScreen(),
    'Promote': const AddProjectScreen(),
    'Test': AddMediaScreen(),
    'Account': ViewMyProfileScreen(), // const TestScreen(),
  };

  List<String> get _tabNames => screenMap.keys.toList();

  void initializeApp() {
    // 7
    Timer(
      const Duration(milliseconds: 2000),
      () {
        // 8
        _initialized = true;
        // 9
        notifyListeners();
      },
    );
  }

  void completeOnboarding() {
    _onboardingComplete = true;
    notifyListeners();
  }

  String getScreenName(int tabIndex) => _tabNames[tabIndex];

  void goToTab(index) {
    _selectedTab = index;
    notifyListeners();
  }

  void goToProfile() {
    _selectedTab = GemberTab.profile;
    notifyListeners();
  }

  void goToAccounts() {
    _selectedTab = GemberTab.account;
    notifyListeners();
  }

  void goToTest() {
    _selectedTab = GemberTab.test;
    notifyListeners();
  }

  ThemeData theme = FooderlichTheme.dark();

  bool themeIsDark() {
    return theme.brightness == Brightness.dark;
  }

  void toggleDarkTheme(bool? setDark) {
    theme = (setDark != null && !setDark) || themeIsDark()
        ? FooderlichTheme.light()
        : FooderlichTheme.dark();
    notifyListeners();
  }

  void logout() {
    // 12
    super.logout();
    _onboardingComplete = false;
    _initialized = false;
    _selectedTab = 0;

    // 13
    initializeApp();
    // 14
    notifyListeners();
  }
}
