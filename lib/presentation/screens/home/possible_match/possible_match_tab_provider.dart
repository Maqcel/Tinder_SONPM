import 'package:flutter/material.dart';
import 'package:tinder/domain/model/possible_match/possible_match.dart';
import 'package:tinder/extensions/build_context_extension.dart';
import 'package:tinder/presentation/common/tabs/tab_definition.dart';
import 'package:tinder/presentation/common/tabs/tab_provider.dart';
import 'package:tinder/presentation/screens/home/possible_match/likes/likes_screen.dart';
import 'package:tinder/presentation/screens/home/possible_match/possible_match_tab_types.dart';

class PossibleMatchTabProvider extends TabProvider<PossibleMatchesTabTypes> {
  final List<PossibleMatch> possibleMatches;
  final List<PossibleMatch> topPicks;

  PossibleMatchTabProvider(this.possibleMatches, this.topPicks);

  @override
  int get count => 2;

  @override
  List<TabDefinition<PossibleMatchesTabTypes>> get tabs => [
        TabDefinition(index: 0, type: PossibleMatchesTabTypes.likes),
        TabDefinition(index: 1, type: PossibleMatchesTabTypes.topPicks),
      ];

  @override
  List<Tab> getTabBarItems(BuildContext context) =>
      (tabs..sort((a, b) => a.index.compareTo(b.index)))
          .map<Tab>((e) => getTabBarItem(context, e.type))
          .toList();

  @override
  Tab getTabBarItem(BuildContext context, PossibleMatchesTabTypes type) {
    switch (type) {
      case PossibleMatchesTabTypes.likes:
        return Tab(
            text: context.localizations
                .possibleMatchesLikedTab(possibleMatches.length.toString()));
      case PossibleMatchesTabTypes.topPicks:
        return Tab(text: context.localizations.topPicksTab);
    }
  }

  @override
  List<Widget> getTabBarViewItems(BuildContext context) =>
      (tabs..sort((a, b) => a.index.compareTo(b.index)))
          .map<Widget>((e) => getTabBarViewItem(context, e.type))
          .toList();

  @override
  Widget getTabBarViewItem(BuildContext context, PossibleMatchesTabTypes type) {
    switch (type) {
      case PossibleMatchesTabTypes.likes:
        return LikesScreen(matchList: possibleMatches);
      case PossibleMatchesTabTypes.topPicks:
        return LikesScreen(matchList: topPicks);
    }
  }
}
