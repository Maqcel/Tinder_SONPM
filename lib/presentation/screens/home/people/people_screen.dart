import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinder/config/dimensions/animation_dimension.dart';
import 'package:tinder/config/dimensions/padding_dimension.dart';
import 'package:tinder/config/theme/color_palette.dart';
import 'package:tinder/domain/model/possible_match/possible_match.dart';
import 'package:tinder/extensions/build_context_extension.dart';
import 'package:tinder/gen/assets.gen.dart';
import 'package:tinder/presentation/common/screen_failure_handler.dart';
import 'package:tinder/presentation/screens/home/people/cubit/people_screen_cubit.dart';
import 'package:tinder/presentation/screens/home/people/widgets/people_card_widget.dart';

class PeopleScreen extends StatefulWidget {
  const PeopleScreen({Key? key}) : super(key: key);

  @override
  _PeopleScreenState createState() => _PeopleScreenState();
}

class _PeopleScreenState extends State<PeopleScreen> with ScreenFailureHandler {
  @override
  void initState() {
    super.initState();
    context.read<PeopleScreenCubit>().fetchData();
  }

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<PeopleScreenCubit, PeopleScreenState>(
        buildWhen: (previous, current) => _buildWhen(previous, current),
        builder: (context, state) => _body(state),
        listener: (context, state) => _onStateChanged(state),
      );

  bool _buildWhen(
    PeopleScreenState previous,
    PeopleScreenState current,
  ) =>
      (current is PeopleLoaded ||
          current is PeopleLoading ||
          previous is PeopleLoaded);

  Widget _body(PeopleScreenState state) => Scaffold(
        appBar: AppBar(
          leading: Assets.images.icons.tinderWhite
              .svg(color: ColorPalette.colorPrimary100),
        ),
        body: AnimatedSwitcher(
          duration: AnimationDimension.durationShort,
          child: _content(context, state),
        ),
      );

  Widget _content(BuildContext context, PeopleScreenState state) {
    if (state is PeopleLoaded) {
      return _peopleScreenCard(state);
    } else {
      return _loadingIndicator(context);
    }
  }

  Widget _peopleScreenCard(PeopleLoaded state) => Padding(
        padding: const EdgeInsets.only(left: PaddingDimension.small),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            state.possibleMatches.isEmpty
                ? Center(
                    child: Text(
                    context.localizations.peopleScreenNoMoreUsersText,
                    style: context.theme.textTheme.headline5,
                  ))
                : Stack(
                    children: state.possibleMatches
                        .map((possibleMatch) => _stackContent(
                              possibleMatch,
                              state,
                            ))
                        .toList()),
          ],
        ),
      );

  Widget _stackContent(PossibleMatch possibleMatch, PeopleLoaded state) {
    final int userIndex = state.possibleMatches.indexOf(possibleMatch);
    final bool isUserInFocus = userIndex == state.possibleMatches.length - 1;

    return Listener(
      onPointerMove: (event) => context
          .read<PeopleScreenCubit>()
          .updateSwipingPosition(event.localDelta.dx),
      onPointerCancel: (event) =>
          context.read<PeopleScreenCubit>().resetPosition(),
      onPointerDown: (event) =>
          context.read<PeopleScreenCubit>().resetPosition(),
      onPointerUp: (event) => context.read<PeopleScreenCubit>().resetPosition(),
      child: _draggableCard(
        state,
        isUserInFocus,
        state.possibleMatches.elementAt(userIndex),
      ),
    );
  }

  Widget _draggableCard(PeopleLoaded state, bool isUserInFocus,
          PossibleMatch possibleMatch) =>
      Draggable(
        child: PeopleCardWidget(
          swipingDirection: state.swipingDirection,
          isUserInFocus: isUserInFocus,
          possibleMatch: possibleMatch,
        ),
        feedback: Material(
          type: MaterialType.transparency,
          child: PeopleCardWidget(
            swipingDirection: state.swipingDirection,
            isUserInFocus: isUserInFocus,
            possibleMatch: possibleMatch,
          ),
        ),
        childWhenDragging: Container(),
        onDragEnd: (details) => _onDragEnd(
          details,
          context,
          possibleMatch.uid,
        ),
      );

  void _onDragEnd(
    DraggableDetails details,
    BuildContext context,
    String possibleMatchUid,
  ) {
    const int minimumDrag = 100;
    if (details.offset.dx > minimumDrag) {
      context.read<PeopleScreenCubit>().onLike(possibleMatchUid);
    } else if (details.offset.dx < -minimumDrag) {
      context.read<PeopleScreenCubit>().onDislike();
    }
  }

  Widget _loadingIndicator(BuildContext context) => Center(
        child: CircularProgressIndicator(
          color: context.theme.colorScheme.secondary,
        ),
      );

  void _onStateChanged(PeopleScreenState state) {
    // Possible match found alert would be here
  }
}
