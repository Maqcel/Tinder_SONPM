import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tinder/config/dimensions/padding_dimension.dart';
import 'package:tinder/config/dimensions/radius_dimension.dart';
import 'package:tinder/extensions/build_context_extension.dart';

class EmailFormInput extends StatelessWidget {
  final TextEditingController _controller;
  final Function()? _onEditingComplete;
  final Function() _onInputChange;

  const EmailFormInput({
    Key? key,
    required TextEditingController controller,
    Function()? onEditingComplete,
    required Function() onInputChange,
  })  : _controller = controller,
        _onEditingComplete = onEditingComplete,
        _onInputChange = onInputChange,
        super(key: key);

  @override
  Widget build(BuildContext context) => Material(
        child: TextFormField(
          controller: _controller,
          keyboardType: TextInputType.emailAddress,
          autocorrect: false,
          textInputAction: TextInputAction.next,
          onEditingComplete: _onEditingComplete,
          style: context.theme.textTheme.caption,
          decoration: _decoration(context),
          onChanged: (_) => _onInputChange(),
        ),
      );

  InputDecoration _decoration(BuildContext context) => InputDecoration(
        isDense: true,
        hintText: context.localizations.signinInputEmailHint,
        contentPadding: const EdgeInsets.only(
          top: PaddingDimension.medium,
          bottom: PaddingDimension.medium,
          right: PaddingDimension.medium,
        ),
        hintStyle: _hintStyle(context),
        border: _idleBorder(context),
        focusedBorder: _focusedBorder(context),
        prefixIcon: _prefixIcon(context),
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

  Widget _prefixIcon(BuildContext context) => const Padding(
        padding: EdgeInsets.all(PaddingDimension.medium),
        child: Icon(Icons.email_outlined),
      );
}
