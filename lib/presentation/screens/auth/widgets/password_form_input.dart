import 'package:flutter/material.dart';
import 'package:tinder/config/dimensions/icon_dimension.dart';
import 'package:tinder/config/dimensions/padding_dimension.dart';
import 'package:tinder/config/dimensions/radius_dimension.dart';
import 'package:tinder/extensions/build_context_extension.dart';

class PasswordFormInput extends StatefulWidget {
  final String _hintText;
  final TextEditingController _controller;
  final FocusNode _focusNode;
  final Function() _onInputChange;

  PasswordFormInput({
    Key? key,
    required String hintText,
    required TextEditingController controller,
    FocusNode? focusNode,
    required Function() onInputChange,
  })  : _hintText = hintText,
        _controller = controller,
        _focusNode = focusNode ?? FocusNode(),
        _onInputChange = onInputChange,
        super(key: key);

  @override
  _PasswordFormInputState createState() => _PasswordFormInputState();
}

class _PasswordFormInputState extends State<PasswordFormInput> {
  bool _isPasswordObscured = true;

  @override
  Widget build(BuildContext context) => Material(
        child: TextFormField(
          focusNode: widget._focusNode,
          controller: widget._controller,
          keyboardType: _keyboardType(),
          obscureText: _isPasswordObscured,
          textInputAction: TextInputAction.done,
          style: context.theme.textTheme.caption,
          decoration: _decoration(context),
          onChanged: (_) => widget._onInputChange(),
        ),
      );

  TextInputType _keyboardType() {
    if (_isPasswordObscured) {
      return TextInputType.visiblePassword;
    } else {
      return TextInputType.text;
    }
  }

  InputDecoration _decoration(BuildContext context) => InputDecoration(
        isDense: true,
        hintText: widget._hintText,
        contentPadding: const EdgeInsets.only(
          top: PaddingDimension.medium,
          bottom: PaddingDimension.medium,
        ),
        hintStyle: _hintStyle(),
        border: _idleBorder(),
        focusedBorder: _focusedBorder(),
        prefixIcon: _prefixIcon(),
        suffixIcon: _suffixIconButton(),
      );

  TextStyle? _hintStyle() => context.theme.textTheme.caption?.copyWith(
        color: context.theme.hintColor,
      );

  BorderRadius _borderRadius() =>
      const BorderRadius.all(RadiusDimension.circularSmall);

  InputBorder _idleBorder() => OutlineInputBorder(
        borderRadius: _borderRadius(),
        borderSide: BorderSide(
          width: 1,
          color: context.theme.hintColor,
        ),
      );

  InputBorder _focusedBorder() => OutlineInputBorder(
        borderRadius: _borderRadius(),
        borderSide: BorderSide(
          width: 1.5,
          color: context.theme.hintColor,
        ),
      );

  Widget _prefixIcon() => const Padding(
      padding: EdgeInsets.all(PaddingDimension.medium),
      child: Icon(Icons.password_rounded));

  Widget _suffixIconButton() => IconButton(
        padding: const EdgeInsets.all(PaddingDimension.medium),
        splashRadius: IconDimension.small / 2 + PaddingDimension.medium,
        onPressed: () => _onObscurePasswordButtonClicked(),
        icon: Icon(
          Icons.remove_red_eye_outlined,
          color: context.theme.textTheme.caption?.color,
          size: IconDimension.small,
        ),
      );

  void _onObscurePasswordButtonClicked() {
    setState(() {
      _isPasswordObscured = !_isPasswordObscured;
    });
  }
}
