import 'dart:async';
import 'package:flutter/material.dart';
import 'package:template/data/user_dao.dart';

// 1
class GemberTab {
  static const int explore = 0;
  static const int profile = 1;
  static const int promote = 2;
}

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

  final _tabNames = <String>['Explore', 'Profile', 'Promote'];

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
