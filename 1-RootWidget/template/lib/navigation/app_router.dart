import 'package:flutter/material.dart';
import 'package:template/ui/screens/your_item_screen.dart';

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
  // 4
  final YourItemManager yourItemManager;

  AppRouter({
    required this.appStateManager,
    required this.yourItemManager,
  }) : navigatorKey = GlobalKey<NavigatorState>() {
    appStateManager.addListener(notifyListeners);
    yourItemManager.addListener(notifyListeners);
  }

  @override
  void dispose() {
    appStateManager.removeListener(notifyListeners);
    yourItemManager.removeListener(notifyListeners);
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

        if (appStateManager.isInitialized && !appStateManager.isLoggedIn)
          LoginScreen.page(),

        if (appStateManager.isLoggedIn && !appStateManager.isOnboardingComplete)
          OnboardingScreen.page(),

        if (appStateManager.isOnboardingComplete)
          Home.page(appStateManager.getSelectedTab),

        // 1
        if (yourItemManager.isCreatingNewItem)
          // 2
          YourItemScreen.page(
            onCreate: (item) {
              // 3
              yourItemManager.addItem(item);
            },
            onUpdate: (item, index) {
              // 4 No update
            },
          ),

        // 1
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
    if (route.settings.name == FooderlichPages.onboardingPath) {
      appStateManager.logout(); // User < back to login from Onboarding page
    }

    if (route.settings.name == FooderlichPages.groceryItemDetails) {
      groceryManager.groceryItemTapped(-1);
    }

    if (route.settings.name == FooderlichPages.profilePath) {
      profileManager.tapOnProfile(false);
    }

    if (route.settings.name == FooderlichPages.raywenderlich) {
      profileManager.tapOnRaywenderlich(false);
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
