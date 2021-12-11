import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tinder/config/dimensions/padding_dimension.dart';
import 'package:tinder/config/dimensions/radius_dimension.dart';
import 'package:tinder/extensions/build_context_extension.dart';

class OnboardingInputField extends StatelessWidget {
  final bool _isName;
  final TextEditingController _controller;
  final Function() _onInputChange;

  const OnboardingInputField({
    Key? key,
    required bool isName,
    required TextEditingController controller,
    required Function() onInputChange,
  })  : _isName = isName,
        _controller = controller,
        _onInputChange = onInputChange,
        super(key: key);

  @override
  Widget build(BuildContext context) => Material(
        child: TextFormField(
          controller: _controller,
          keyboardType: TextInputType.multiline,
          autocorrect: false,
          textInputAction: TextInputAction.next,
          style: context.theme.textTheme.caption,
          decoration: _decoration(context),
          onChanged: (_) => _onInputChange(),
        ),
      );

  InputDecoration _decoration(BuildContext context) => InputDecoration(
        hintText: _isName
            ? context.localizations.onboardingInputHintName
            : context.localizations.onboardingInputHintBio,
        contentPadding: const EdgeInsets.all(PaddingDimension.small),
        hintStyle: _hintStyle(context),
        border: _idleBorder(context),
        focusedBorder: _focusedBorder(context),
      );

  TextStyle? _hintStyle(BuildContext context) =>
      context.theme.textTheme.caption?.copyWith(
        color: context.theme.hintColor,
      );

  BorderRadius _borderRadius() =>
      const BorderRadius.all(RadiusDimension.circularSmall);

  InputBorder _idleBorder(BuildContext context) => OutlineInputBorder(
        borderRadius: _borderRadius(),
        borderSide: BorderSide(
          width: 1,
          color: context.theme.hintColor,
        ),
      );

  InputBorder _focusedBorder(BuildContext context) => OutlineInputBorder(
        borderRadius: _borderRadius(),
        borderSide: BorderSide(
          width: 1.5,
          color: context.theme.hintColor,
        ),
      );
}
