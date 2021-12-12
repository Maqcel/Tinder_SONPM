import 'package:flutter/material.dart';
import 'package:tinder/domain/model/onboarding/gender.dart';
import 'package:tinder/extensions/build_context_extension.dart';

class OnboardingGenderPicker extends StatelessWidget {
  final Gender? _gender;
  final Function(Gender) _chooseGender;

  const OnboardingGenderPicker({
    Key? key,
    required Gender? gender,
    required Function(Gender) chooseGender,
  })  : _gender = gender,
        _chooseGender = chooseGender,
        super(key: key);

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _radioPicker(context, Gender.man),
          _radioPicker(context, Gender.woman),
        ],
      );

  Widget _radioPicker(
    BuildContext context,
    Gender gender,
  ) =>
      Column(
        children: [
          Radio(
            value: gender,
            groupValue: _gender,
            onChanged: (gender) => _chooseGender(gender as Gender),
          ),
          Text(
            gender.toValueString(),
            style: context.theme.textTheme.bodyText1,
          ),
        ],
      );
}
