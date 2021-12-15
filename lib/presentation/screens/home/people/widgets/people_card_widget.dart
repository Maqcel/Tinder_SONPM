import 'package:flutter/material.dart';
import 'package:tinder/config/dimensions/padding_dimension.dart';
import 'package:tinder/config/theme/color_palette.dart';
import 'package:tinder/domain/model/possible_match/possible_match.dart';
import 'package:tinder/extensions/build_context_extension.dart';
import 'package:tinder/presentation/screens/home/people/swiping_direction.dart';

class PeopleCardWidget extends StatelessWidget {
  final SwipingDirection _swipingDirection;
  final bool _isUserInFocus;
  final PossibleMatch _possibleMatch;

  const PeopleCardWidget({
    Key? key,
    required SwipingDirection swipingDirection,
    required bool isUserInFocus,
    required PossibleMatch possibleMatch,
  })  : _swipingDirection = swipingDirection,
        _isUserInFocus = isUserInFocus,
        _possibleMatch = possibleMatch,
        super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        width: MediaQuery.of(context).size.width * 0.95,
        height: MediaQuery.of(context).size.height * 0.85 - kToolbarHeight,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(_possibleMatch.photoUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: _peopleCardShadow(),
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              _buildUserCard(context),
              if (_isUserInFocus) _buildLikeBadge(context, _swipingDirection)
            ],
          ),
        ),
      );

  BoxDecoration _peopleCardShadow() => BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(color: Colors.black12, spreadRadius: 0.5),
        ],
        gradient: const LinearGradient(
          colors: [Colors.black12, Colors.black87],
          begin: Alignment.center,
          stops: [0.4, 1],
          end: Alignment.bottomCenter,
        ),
      );

  Widget _buildUserCard(BuildContext context) => Padding(
        padding: const EdgeInsets.all(PaddingDimension.small),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _possibleMatch.name +
                  ', ' +
                  (DateTime.now().year - _possibleMatch.birthDate.year)
                      .toString(),
              style: context.theme.textTheme.headline3
                  ?.copyWith(color: ColorPalette.white),
            ),
            const SizedBox(height: PaddingDimension.small),
            Text(
              _possibleMatch.bio,
              style: context.theme.textTheme.headline5
                  ?.copyWith(color: ColorPalette.white),
              maxLines: 7,
            ),
          ],
        ),
      );

  Widget _buildLikeBadge(
      BuildContext context, SwipingDirection swipingDirection) {
    final isSwipingRight = swipingDirection == SwipingDirection.right;
    final color =
        isSwipingRight ? ColorPalette.greenLight : ColorPalette.redLight;
    final angle = isSwipingRight ? -0.5 : 0.5;

    if (swipingDirection == SwipingDirection.none) {
      return const SizedBox();
    } else {
      return Positioned(
        top: PaddingDimension.large,
        right: isSwipingRight ? null : PaddingDimension.large,
        left: isSwipingRight ? PaddingDimension.large : null,
        child: Transform.rotate(
          angle: angle,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border.all(color: color, width: 2),
            ),
            child: Text(
              isSwipingRight
                  ? context.localizations.peopleScreenSwipeLikeActionBadgeText
                  : context.localizations.peopleScreenSwipeNopeActionBadgeText,
              style: context.theme.textTheme.headline2?.copyWith(color: color),
            ),
          ),
        ),
      );
    }
  }
}
