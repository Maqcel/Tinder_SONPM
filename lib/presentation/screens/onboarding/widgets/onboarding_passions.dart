import 'package:flutter/material.dart';
import 'package:tinder/config/theme/color_palette.dart';
import 'package:tinder/domain/model/onboarding/passions.dart';
import 'package:tinder/extensions/build_context_extension.dart';

class OnboardingPassions extends StatelessWidget {
  final List<Passions> _chosenPassions;
  final Function(Passions) _onChipTap;

  const OnboardingPassions({
    Key? key,
    required List<Passions> chosenPassions,
    required Function(Passions) onChipTap,
  })  : _chosenPassions = chosenPassions,
        _onChipTap = onChipTap,
        super(key: key);

  @override
  Widget build(BuildContext context) => Column(children: _createChips(context));

  List<Widget> _createChips(BuildContext context) => [
        _chipsRow(context, 0),
        _chipsRow(context, 3),
        _chipsRow(context, 6),
        _chipsRow(context, 9),
      ];

  Widget _chipsRow(BuildContext context, int startIndex) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          3,
          (index) => GestureDetector(
            onTap: () => _onChipTap(Passions.values[startIndex + index]),
            child: Chip(
              label: Text(
                Passions.values[startIndex + index].toValueString(),
                style: context.theme.textTheme.button,
              ),
              backgroundColor:
                  _chosenPassions.contains(Passions.values[startIndex + index])
                      ? ColorPalette.colorPrimaryBase
                      : ColorPalette.grayLightest,
            ),
          ),
        ),
      );
}
