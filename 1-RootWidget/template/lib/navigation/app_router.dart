import 'package:flutter/material.dart';
import 'package:template/data/user_dao.dart';
import 'package:template/ui/main_screen.dart';
import 'package:template/ui/models/consumer_manager.dart';
import 'package:template/ui/models/project_manager.dart';
import 'package:template/ui/models/user_manager.dart';
import 'package:template/ui/screens/edit_my_profile_screen.dart';
import 'package:template/ui/screens/login_screen.dart';

import '../ui/models/models.dart';
import '../ui/screens/screens.dart';

// 1
class AppRouter extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  // 2
  // GlobalKey is required to retrieve the current navigator.
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  // 3
  final AppStateManager appStateManager;
  

  final ProjectManager projectManager;

  final UserManager myUserManager;

  AppRouter({
    required this.appStateManager,
    required this.myUserManager,
    required this.projectManager,
  }) : navigatorKey = GlobalKey<NavigatorState>() {
    appStateManager.addListener(notifyListeners);
    myUserManager.addListener(notifyListeners);
    projectManager.addListener(notifyListeners);
  }

  @override
  void dispose() {
    appStateManager.removeListener(notifyListeners);
    // profileManager.removeListener(notifyListeners);
    projectManager.removeListener(notifyListeners);
    super.dispose();
  }

  // 6
  @override
  Widget build(BuildContext context) {
    // 7

    return Navigator(
      // 8
      key: navigatorKey,
      onPopPage: _handlePopPage,
      // 9
      pages: [
        if (!appStateManager.isInitialized) SplashScreen.page(),

        if (appStateManager.isInitialized && !appStateManager.isLoggedIn())
          Login.page(), // LoginScreen.page(),

        // if (appStateManager.isLoggedIn && !appStateManager.isOnboardingComplete)
        //   SplashScreen.page(),

        // if (appStateManager.isOnboardingComplete)
        //   MainScreen.page(appStateManager.getSelectedTab),

        if (appStateManager.isLoggedIn())
          MainScreen.page(appStateManager.getSelectedTab),

        // 1
        // if (profileManager.isCreatingNewConsumer)
        //   // 2
        //   ProfileScreen.page(
        //     onCreate: (item) {
        //       // 3
        //       profileManager.addConsumer(item);
        //     },
        //     onUpdate: (item, index) {
        //       // 4 No update
        //     },
        //   ),

        // // 1
        
        
        
          
      ],
    );
  }

  bool _handlePopPage(
      // 1
      Route<dynamic> route,
      // 2
      result) {
    // 3
    if (!route.didPop(result)) {
      // 4
      return false;
    }

    // 5
    if (route.settings.name == TemplatePages.onboardingPath) {
      appStateManager.logout(); // User < back to login from Onboarding page
    }

    if (route.settings.name == TemplatePages.profilePath) {
      appStateManager.goToTab(appStateManager.getSelectedTab);
    }

    if (route.settings.name == TemplatePages.testPath) {
      appStateManager.goToTab(appStateManager.getSelectedTab);
    }
    // 6
    return true;
  }

  // 10
  // This is set to null here as this is required for Flutter webapps,
  // but we are not supporting these here.
  @override
  Future<void> setNewRoutePath(configuration) async => null;
}
