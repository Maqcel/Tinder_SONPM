import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinder/config/dimensions/icon_dimension.dart';
import 'package:tinder/extensions/build_context_extension.dart';
import 'package:tinder/presentation/screens/home/home_screen_page_provider.dart';
import 'package:tinder/presentation/screens/home/home_screen_page_type.dart';
import 'package:tinder/presentation/screens/home/navigation/cubit/home_navigation_cubit.dart';
import 'package:tinder/presentation/screens/home/navigation/home_screen_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeScreenRouter _routerDelegate = HomeScreenRouter();
  ChildBackButtonDispatcher? _backButtonDispatcher;

  @override
  void didChangeDependencies() {
    _initBackButtonDispatcher();
    super.didChangeDependencies();
  }

  void _initBackButtonDispatcher() {
    _backButtonDispatcher ??=
        ChildBackButtonDispatcher(context.router.backButtonDispatcher!);
    _backButtonDispatcher?.takePriority();
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<HomeNavigationCubit, HomeNavigationState>(
        builder: (context, state) => _body(state),
      );

  Widget _body(HomeNavigationState state) => Scaffold(
        body: Router(
          routerDelegate: _routerDelegate,
          backButtonDispatcher: _backButtonDispatcher,
        ),
        bottomNavigationBar: _bottomNavigationBar(state),
      );

  BottomNavigationBar _bottomNavigationBar(HomeNavigationState state) =>
      BottomNavigationBar(
        iconSize: IconDimension.small,
        items: HomeScreenPageProvider.getBottomNavBarItems(context),
        currentIndex: HomeScreenPageProvider.getIndexByState(state),
        onTap: (index) => _onSelectedPageIndexChanged(index),
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      );

  void _onSelectedPageIndexChanged(int newIndex) {
    HomeScreenPageType selectedPageType =
        HomeScreenPageProvider.getPageTypeByIndex(newIndex);

    context
        .read<HomeNavigationCubit>()
        .onSelectedPageTypeChanged(selectedPageType);
  }
}
