import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/src/provider.dart';
import 'package:tinder/config/theme/color_palette.dart';
import 'package:tinder/extensions/build_context_extension.dart';
import 'package:tinder/gen/assets.gen.dart';
import 'package:tinder/presentation/screens/home/possible_match/cubit/possible_match_cubit.dart';
import 'package:tinder/presentation/screens/home/possible_match/cubit/possible_match_state.dart';
import 'package:tinder/presentation/screens/home/possible_match/possible_match_tab_provider.dart';

class PossibleMatchScreen extends StatefulWidget {
  const PossibleMatchScreen({Key? key}) : super(key: key);

  @override
  _PossibleMatchScreenState createState() => _PossibleMatchScreenState();
}

class _PossibleMatchScreenState extends State<PossibleMatchScreen> {
  final PossibleMatchTabProvider tabProvider = PossibleMatchTabProvider();

  @override
  void initState() {
    super.initState();
    // context.read<PossibleMatchScreenCubit>().refreshData();
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<PossibleMatchScreenCubit, PossibleMatchState>(
          builder: (context, state) => _body(context, state));
}

Widget _body(BuildContext context, PossibleMatchState state) =>
    DefaultTabController(length: 2, child: Scaffold(
      // TODO: why tabProvider.count is not working ???
      appBar:     AppBar(
    leading: Assets.images.icons.tinderWhite
        .svg(color: ColorPalette.colorPrimary100),
    ),
      // TODO: i don't have access to tabProvider
      // body: TabBarView(
      //   children: tabProvider.getTabBarViewItems(context);
      // ),
    ));
