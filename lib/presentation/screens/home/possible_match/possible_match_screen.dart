import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinder/config/dimensions/animation_dimension.dart';
import 'package:tinder/config/theme/color_palette.dart';
import 'package:tinder/extensions/build_context_extension.dart';
import 'package:tinder/gen/assets.gen.dart';
import 'package:tinder/presentation/common/screen_failure_handler.dart';
import 'package:tinder/presentation/screens/home/possible_match/cubit/possible_match_cubit.dart';
import 'package:tinder/presentation/screens/home/possible_match/cubit/possible_match_state.dart';
import 'package:tinder/presentation/screens/home/possible_match/possible_match_tab_provider.dart';

class PossibleMatchScreen extends StatefulWidget {
  const PossibleMatchScreen({Key? key}) : super(key: key);

  @override
  _PossibleMatchScreenState createState() => _PossibleMatchScreenState();
}

class _PossibleMatchScreenState extends State<PossibleMatchScreen>
    with ScreenFailureHandler {
  late final PossibleMatchTabProvider tabProvider;

  @override
  void initState() {
    super.initState();
    context.read<PossibleMatchScreenCubit>().onScreenOpened();
  }

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<PossibleMatchScreenCubit, PossibleMatchState>(
        builder: (context, state) => _body(state),
        buildWhen: (previous, current) => _buildWhen(previous, current),
        listener: (context, state) => _onStateChanged(state),
      );

  Widget _body(PossibleMatchState state) => AnimatedSwitcher(
        duration: AnimationDimension.durationShort,
        child: _content(context, state),
      );

  Widget _content(BuildContext context, PossibleMatchState state) {
    if (state is PossibleMatchPlanLoaded) {
      tabProvider =
          PossibleMatchTabProvider(state.possibleMatches, state.topPicks);
      return _tabs(context, state);
    } else {
      return _loadingIndicator(context);
    }
  }

  bool _buildWhen(
    PossibleMatchState previous,
    PossibleMatchState current,
  ) =>
      (current is PossibleMatchPlanLoading ||
          current is PossibleMatchPlanLoaded);

  Widget _tabs(BuildContext context, PossibleMatchState state) =>
      DefaultTabController(
          length: tabProvider.count,
          child: Scaffold(
            appBar: AppBar(
              leading: Assets.images.icons.tinderWhite
                  .svg(color: ColorPalette.colorPrimary100),
              bottom: TabBar(
                tabs: tabProvider.getTabBarItems(context),
              ),
            ),
            body: TabBarView(children: tabProvider.getTabBarViewItems(context)),
          ));

  Widget _loadingIndicator(BuildContext context) => Center(
        child: CircularProgressIndicator(
          color: context.theme.colorScheme.secondary,
        ),
      );

  void _onStateChanged(PossibleMatchState state) {
    if (state is PossibleMatchLoadError) {
      handleFailureInUi(context: context, failure: state.failure);
    }
  }
}
