import 'package:flutter/material.dart';
import 'package:tinder/config/dimensions/icon_dimension.dart';
import 'package:tinder/extensions/build_context_extension.dart';

class CancelIconButton extends StatelessWidget {
  final Function? _onClick;

  const CancelIconButton({Key? key, Function? onClick})
      : _onClick = onClick,
        super(key: key);

  @override
  Widget build(BuildContext context) => IconButton(
        icon: _asset(context),
        splashRadius: IconDimension.small,
        iconSize: IconDimension.small,
        onPressed: () => _onIconClicked(context),
      );

  Widget _asset(BuildContext context) => Icon(
        Icons.arrow_back,
        color: context.theme.appBarTheme.titleTextStyle?.color,
      );

  void _onIconClicked(BuildContext context) {
    if (_onClick != null) {
      _onClick!();
    } else {
      Navigator.of(context).maybePop();
    }
  }
}
