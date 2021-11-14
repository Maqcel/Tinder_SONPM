import 'package:flutter/material.dart';
import 'package:tinder/presentation/common/navigation/cubit_router.dart';
import 'package:tinder/presentation/page_transitions/fade_transition_page.dart';
import 'package:tinder/presentation/screens/home/chat/chat_screen.dart';
import 'package:tinder/presentation/screens/home/navigation/cubit/home_navigation_cubit.dart';
import 'package:tinder/presentation/screens/home/people/people_screen.dart';
import 'package:tinder/presentation/screens/home/possible_match/possible_match_screen.dart';
import 'package:tinder/presentation/screens/home/profile/profile_screen.dart';
import 'package:tinder/routing/app_routes.dart';

class HomeScreenRouter
    extends CubitRouter<HomeNavigationCubit, HomeNavigationState, void> {
  @override
  GlobalKey<NavigatorState> internalNavigationKey =
      GlobalKey(debugLabel: 'HomeRouterKey');

  @override
  List<Page> getPageStack(BuildContext context, HomeNavigationState state) {
    List<Page> pageStack = [];

    if (state is HomePeople) {
      pageStack.add(FadeTransitionPage.fromRoute(
        route: AppRoutes.homePeople,
        child: const PeopleScreen(),
      ));
    }

    if (state is HomeChat) {
      pageStack.add(FadeTransitionPage.fromRoute(
        route: AppRoutes.homeChat,
        child: const ChatScreen(),
      ));
    }

    if (state is HomePossibleMatch) {
      pageStack.add(FadeTransitionPage.fromRoute(
        route: AppRoutes.homePossibleMatch,
        child: const PossibleMatchScreen(),
      ));
    }

    if (state is HomeProfile) {
      pageStack.add(FadeTransitionPage.fromRoute(
        route: AppRoutes.homeProfile,
        child: const ProfileScreen(),
      ));
    }

    return pageStack;
  }

  @override
  Future<void> setNewRoutePath(void configuration) {
    throw UnimplementedError();
  }
}
