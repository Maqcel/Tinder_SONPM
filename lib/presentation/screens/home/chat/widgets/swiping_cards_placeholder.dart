import 'package:flutter/material.dart';
import 'package:tinder/config/dimensions/padding_dimension.dart';
import 'package:tinder/config/dimensions/radius_dimension.dart';
import 'package:tinder/config/theme/color_palette.dart';
import 'package:tinder/extensions/build_context_extension.dart';

class SwipingCardPlaceholder extends StatelessWidget {
  const SwipingCardPlaceholder({Key? key}) : super(key: key);
  final Color greyCardColor = const Color.fromRGBO(253, 253, 253, 1.0);
  final Color greenCardColor = const Color.fromRGBO(248, 254, 252, 1.0);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(PaddingDimension.medium),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _cardsCombined(context),
              Padding(
                padding: const EdgeInsets.all(PaddingDimension.medium),
                child: Text(
                  context.localizations.chatNoMatchesTitleText,
                  style: context.theme.textTheme.headline2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: PaddingDimension.large,
                ),
                child: Text(
                  context.localizations.chatNoMatchesBodyText,
                  style: context.theme.textTheme.bodyText1?.copyWith(
                    color: ColorPalette.grayLight,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      );

  Widget _cardsCombined(BuildContext context) => SizedBox(
        height: MediaQuery.of(context).size.height / 3,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: const Alignment(0, 1.0),
              child: Transform.scale(
                scale: 0.8,
                child: _card(context: context, color: greyCardColor),
              ),
            ),
            Align(
              alignment: const Alignment(0, 0.5),
              child: Transform.scale(
                scale: 0.9,
                child: _card(context: context, color: greyCardColor),
              ),
            ),
            _card(context: context, color: greyCardColor),
            Align(
              alignment: const Alignment(0.33, -0.6),
              child: Transform.rotate(
                angle: 0.28,
                child: _card(
                  context: context,
                  color: greenCardColor,
                  child: _cardText(context),
                ),
              ),
            ),
          ],
        ),
      );

  Widget _card({
    required BuildContext context,
    required Color color,
    Widget? child,
  }) =>
      Container(
        width: MediaQuery.of(context).size.width / 3,
        height: MediaQuery.of(context).size.height / 4,
        decoration: BoxDecoration(
          border: Border.all(
            color: color != greenCardColor
                ? ColorPalette.grayLight.withOpacity(0.4)
                : ColorPalette.green,
            width: 3.0,
          ),
          borderRadius: const BorderRadius.all(RadiusDimension.circularMedium),
          color: color,
        ),
        child: Center(child: child),
      );

  Widget _cardText(BuildContext context) => Transform.rotate(
        angle: -0.55,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: ColorPalette.green, width: 3.0),
            borderRadius: const BorderRadius.all(RadiusDimension.circularSmall),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: PaddingDimension.small),
            child: Text(
              context.localizations.chatNoMatchesCardText,
              style: context.theme.textTheme.headline2
                  ?.copyWith(color: ColorPalette.green),
            ),
          ),
        ),
      );
}
