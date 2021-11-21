import 'package:flutter/material.dart';
import 'package:tinder/config/dimensions/padding_dimension.dart';
import 'package:tinder/config/theme/color_palette.dart';
import 'package:tinder/domain/model/user/match.dart';
import 'package:tinder/extensions/build_context_extension.dart';
import 'package:tinder/presentation/screens/home/people/swiping_direction.dart';

class PeopleCardWidget extends StatelessWidget {
  final SwipingDirection _swipingDirection;
  final Match _match;

  const PeopleCardWidget({
    Key? key,
    required SwipingDirection swipingDirection,
    required Match match,
  })  : _swipingDirection = swipingDirection,
        _match = match,
        super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        width: MediaQuery.of(context).size.width * 0.95,
        height: MediaQuery.of(context).size.height * 0.95,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(_match.photoUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: _peopleCardShadow(),
          child: Stack(
            children: [
              if (_swipingDirection != SwipingDirection.none)
                buildLikeBadge(context, _swipingDirection)
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

  Widget buildLikeBadge(
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
