import 'package:flutter/material.dart';
import 'package:tinder/presentation/app/navigation/cubit/user_session_navigation_cubit.dart';
import 'package:tinder/presentation/common/navigation/cubit_router.dart';
import 'package:tinder/presentation/page_transitions/slide_transition_page.dart';
import 'package:tinder/presentation/screens/auth/auth_screen.dart';
import 'package:tinder/presentation/screens/splash/splash_screen.dart';
import 'package:tinder/routing/app_routes.dart';

/// Router on top of the Widget Tree
class UserSessionRouter extends CubitRouter<UserSessionNavigationCubit,
    UserSessionNavigationState, void> {
  @override
  GlobalKey<NavigatorState> internalNavigationKey =
      GlobalKey(debugLabel: 'UserSessionRouterKey');

  @override
  List<Page> getPageStack(
      BuildContext context, UserSessionNavigationState state) {
    List<Page> pageStack = [];

    if (state is UserSessionNavigationInitial) {
      pageStack.add(
        SlideTransitionPage<void>(
          name: AppRoutes.splash.name,
          key: AppRoutes.splash.valueKey,
          child: const SplashScreen(),
        ),
      );
    }

    if (state is UserSessionNavigationLoggedIn) {
      pageStack.add(
        SlideTransitionPage<void>(
          name: AppRoutes.home.name,
          key: AppRoutes.home.valueKey,
          child: const AuthScreen(),
        ),
      );
    }

    if (state is UserSessionNavigationLoggedOut) {
      pageStack.add(
        SlideTransitionPage<void>(
          name: AppRoutes.login.name,
          key: AppRoutes.login.valueKey,
          child: const AuthScreen(),
        ),
      );
    }

    return pageStack;
  }
}
