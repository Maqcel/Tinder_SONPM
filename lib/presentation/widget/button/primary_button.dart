import 'package:flutter/material.dart';
import 'package:tinder/config/dimensions/padding_dimension.dart';
import 'package:tinder/config/dimensions/radius_dimension.dart';
import 'package:tinder/extensions/build_context_extension.dart';
import 'package:tinder/presentation/widget/button/button_height.dart';

// TODO: Create gradient for button instead of solid color
class PrimaryButton extends StatelessWidget {
  final String _buttonText;
  final ButtonHeight _height;
  final bool _expanded;
  final bool _isEnabled;
  final bool _isError;
  final Function() _onPressed;
  final bool _onlyOutlineColor;

  const PrimaryButton({
    Key? key,
    required String text,
    required Function() onPressed,
    ButtonHeight? height,
    bool? expanded,
    bool? isEnabled,
    bool? isError,
    double? minHeight,
    double? minWidth,
    bool? onlyOutlineColor,
  })  : _buttonText = text,
        _height = height ?? ButtonHeight.large,
        _expanded = expanded ?? true,
        _isEnabled = isEnabled ?? true,
        _isError = isError ?? false,
        _onPressed = onPressed,
        _onlyOutlineColor = onlyOutlineColor ?? false,
        super(key: key);

  @override
  Widget build(BuildContext context) => _expanded
      ? Expanded(child: _buttonContent(context))
      : _buttonContent(context);

  Widget _buttonContent(BuildContext context) => ElevatedButton(
        onPressed: () => _onButtonPressed(),
        child: _content(context),
        style: _onlyOutlineColor
            ? ButtonStyle(
                padding: _contentPadding(context),
                elevation: _elevation(),
                backgroundColor: _backgroundColor(context),
                textStyle: _textStyle(context),
                shape: _shape(context),
                side: _outlineColor(context),
                overlayColor: _outlineRippleColor(),
              )
            : ButtonStyle(
                padding: _contentPadding(context),
                elevation: _elevation(),
                backgroundColor: _backgroundColor(context),
                textStyle: _textStyle(context),
                shape: _shape(context),
              ),
      );

  void _onButtonPressed() {
    if (_isEnabled) _onPressed();
  }

  Widget _content(BuildContext context) => Text(
        _buttonText,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: _contentTextColor(context),
        ),
      );

  Color _contentTextColor(BuildContext context) =>
      _onlyOutlineColor ? _colorFromTheme(context) : Colors.white;

  MaterialStateProperty<double> _elevation() => MaterialStateProperty.all(0);

  MaterialStateProperty<Color> _backgroundColor(BuildContext context) {
    if (!_onlyOutlineColor) {
      return MaterialStateProperty.all(_colorFromTheme(context));
    } else {
      return MaterialStateProperty.all(Colors.white);
    }
  }

  Color _colorFromTheme(BuildContext context) {
    if (_isError) {
      return _isEnabled
          ? context.theme.colorScheme.error
          : context.theme.disabledColor;
    } else {
      return _isEnabled
          ? context.theme.colorScheme.primary
          : context.theme.disabledColor;
    }
  }

  MaterialStateProperty<TextStyle?> _textStyle(BuildContext context) {
    if (_height == ButtonHeight.small) {
      return MaterialStateProperty.all(
          context.theme.textTheme.button?.copyWith(fontSize: 13));
    } else {
      return MaterialStateProperty.all(context.theme.textTheme.button);
    }
  }

  MaterialStateProperty<EdgeInsets> _contentPadding(BuildContext context) =>
      MaterialStateProperty.all(_expanded
          ? _expandedContentPadding(context)
          : _shrinkContentPadding(context));

  EdgeInsets _expandedContentPadding(BuildContext context) {
    switch (_height) {
      case ButtonHeight.small:
        return const EdgeInsets.only(
          top: PaddingDimension.small / 2,
          bottom: PaddingDimension.small / 2,
          left: PaddingDimension.small,
          right: PaddingDimension.small,
        );
      case ButtonHeight.medium:
        return const EdgeInsets.only(
          top: PaddingDimension.small,
          bottom: PaddingDimension.small,
          left: PaddingDimension.small,
          right: PaddingDimension.small,
        );
      case ButtonHeight.large:
        return const EdgeInsets.only(
          top: PaddingDimension.medium / 2,
          bottom: PaddingDimension.medium / 2,
          left: PaddingDimension.small,
          right: PaddingDimension.small,
        );
    }
  }

  EdgeInsets _shrinkContentPadding(BuildContext context) {
    switch (_height) {
      case ButtonHeight.small:
        return const EdgeInsets.only(
          top: PaddingDimension.small / 2,
          bottom: PaddingDimension.small / 2,
          left: PaddingDimension.small,
          right: PaddingDimension.small,
        );
      case ButtonHeight.medium:
        return const EdgeInsets.only(
          top: PaddingDimension.small,
          bottom: PaddingDimension.small,
          left: PaddingDimension.large / 2,
          right: PaddingDimension.large / 2,
        );
      case ButtonHeight.large:
        return const EdgeInsets.only(
          top: PaddingDimension.medium / 2,
          bottom: PaddingDimension.medium / 2,
          left: PaddingDimension.large,
          right: PaddingDimension.large,
        );
    }
  }

  MaterialStateProperty<OutlinedBorder> _shape(BuildContext context) =>
      MaterialStateProperty.all(RoundedRectangleBorder(
        borderRadius: _outlineRadius(),
      ));

  BorderRadius _outlineRadius() =>
      const BorderRadius.all(RadiusDimension.circularLarge);

  MaterialStateProperty<BorderSide?> _outlineColor(BuildContext context) =>
      MaterialStateProperty.all(
        BorderSide(
          color: _colorFromTheme(context),
          width: 1.0,
        ),
      );

  MaterialStateProperty<Color?> _outlineRippleColor() =>
      MaterialStateProperty.resolveWith(
        (states) => states.contains(MaterialState.pressed) ? Colors.grey : null,
      );
}
