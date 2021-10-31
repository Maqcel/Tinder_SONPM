import 'package:flutter/material.dart';
import 'package:tinder/gen/assets.gen.dart';
import 'package:tinder/presentation/screens/home/home_screen_page.dart';
import 'package:tinder/presentation/screens/home/home_screen_page_type.dart';
import 'package:tinder/presentation/screens/home/navigation/cubit/home_navigation_cubit.dart';

class HomeScreenPageProvider {
  static List<HomeScreenPage> pages = [
    HomeScreenPage(index: 0, type: HomeScreenPageType.people),
    HomeScreenPage(index: 1, type: HomeScreenPageType.possibleMatch),
    HomeScreenPage(index: 2, type: HomeScreenPageType.chat),
    HomeScreenPage(index: 3, type: HomeScreenPageType.profile),
  ];

  static int getIndexByState(HomeNavigationState state) =>
      getIndexByPageType(getPageTypeByState(state));

  static HomeScreenPageType getPageTypeByState(HomeNavigationState state) {
    if (state is HomePeople) {
      return HomeScreenPageType.people;
    } else if (state is HomeChat) {
      return HomeScreenPageType.chat;
    } else if (state is HomePossibleMatch) {
      return HomeScreenPageType.possibleMatch;
    } else if (state is HomeProfile) {
      return HomeScreenPageType.profile;
    } else {
      throw ArgumentError('State $state couldn\'t be mapped to page type');
    }
  }

  static int getIndexByPageType(HomeScreenPageType type) =>
      pages.firstWhere((element) => element.type == type, orElse: () {
        throw ArgumentError('Unsupported Home Screen page type: $type');
      }).index;

  static HomeScreenPageType getPageTypeByIndex(int index) =>
      pages.firstWhere((element) => element.index == index, orElse: () {
        throw IndexError(index, pages);
      }).type;

  static List<BottomNavigationBarItem> getBottomNavBarItems(
          BuildContext context) =>
      pages.map((page) => getBottomNavBarItem(context, page.type)).toList();

  static BottomNavigationBarItem getBottomNavBarItem(
      BuildContext context, HomeScreenPageType type) {
    Color? activeIconColor = Colors.pink[600];
    Color? idleIconColor = Colors.grey[600];

    // TODO: Add additional icons for rest of the navigation
    switch (type) {
      case HomeScreenPageType.people:
        return BottomNavigationBarItem(
          label: '',
          icon: Assets.images.icons.tinderWhite.svg(
            color: idleIconColor,
          ),
          activeIcon: Assets.images.icons.tinderWhite.svg(
            color: activeIconColor,
          ),
        );
      case HomeScreenPageType.possibleMatch:
        return BottomNavigationBarItem(
          label: '',
          icon: Icon(
            Icons.star_outlined,
            color: idleIconColor,
          ),
          activeIcon: Icon(
            Icons.star_outlined,
            color: activeIconColor,
          ),
        );
      case HomeScreenPageType.chat:
        return BottomNavigationBarItem(
          label: '',
          icon: Icon(
            Icons.chat_bubble_outline_rounded,
            color: idleIconColor,
          ),
          activeIcon: Icon(
            Icons.chat_bubble_outline_rounded,
            color: activeIconColor,
          ),
        );
      case HomeScreenPageType.profile:
        return BottomNavigationBarItem(
          label: '',
          icon: Icon(
            Icons.person,
            color: idleIconColor,
          ),
          activeIcon: Icon(
            Icons.person,
            color: activeIconColor,
          ),
        );
      default:
        throw ArgumentError('Unsupported Home Screen page type: $type');
    }
  }
}
