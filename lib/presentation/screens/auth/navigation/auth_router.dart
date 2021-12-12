import 'package:flutter/material.dart';
import 'package:tinder/presentation/common/navigation/cubit_router.dart';
import 'package:tinder/presentation/page_transitions/slide_transition_page.dart';
import 'package:tinder/presentation/screens/auth/login/login_screen.dart';
import 'package:tinder/presentation/screens/auth/navigation/cubit/auth_navigation_cubit.dart';
import 'package:tinder/presentation/screens/auth/signup/signup_screen.dart';
import 'package:tinder/routing/app_routes.dart';

class AuthRouter
    extends CubitRouter<AuthNavigationCubit, AuthNavigationState, void> {
  @override
  GlobalKey<NavigatorState> internalNavigationKey =
      GlobalKey(debugLabel: 'AuthRouterKey');

  @override
  List<Page> getPageStack(BuildContext context, AuthNavigationState state) {
    List<Page> pageStack = [];

    if (state is AuthNavigationLogin) {
      pageStack.add(SlideTransitionPage.fromRoute(
        route: AppRoutes.login,
        child: const LoginScreen(),
      ));
    }

    if (state is AuthNavigationSignup) {
      pageStack.add(SlideTransitionPage.fromRoute(
        route: AppRoutes.login,
        child: const LoginScreen(),
      ));
      pageStack.add(SlideTransitionPage.fromRoute(
        route: AppRoutes.signup,
        child: const SignupScreen(),
      ));
    }

    return pageStack;
  }
}
