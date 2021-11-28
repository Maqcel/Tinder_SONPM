import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tinder/presentation/common/tabs/tab_definition.dart';

abstract class TabProvider<R> {
  abstract final int count;
  abstract final List<TabDefinition<R>> tabs;

  List<Tab> getTabBarItems(BuildContext context);

  Tab getTabBarItem(BuildContext context, R type);

  List<Widget> getTabBarViewItems(BuildContext context);

  Widget getTabBarViewItem(BuildContext context, R type);
}
