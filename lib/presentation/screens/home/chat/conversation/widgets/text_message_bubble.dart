import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as flyer;
import 'package:tinder/config/dimensions/padding_dimension.dart';
import 'package:tinder/config/theme/color_palette.dart';
import 'package:tinder/extensions/build_context_extension.dart';

class TextMessageBubble extends StatelessWidget {
  static const double _bubbleRadius = 24;
  final bool _fromCurrentUser;
  final double _maxWidth;
  final flyer.TextMessage? _message;
  final String? _messageText;

  const TextMessageBubble({
    Key? key,
    required bool fromCurrentUser,
    required double maxWidth,
    flyer.TextMessage? message,
    String? text,
  })  : _fromCurrentUser = fromCurrentUser,
        _maxWidth = maxWidth,
        _message = message,
        _messageText = text,
        super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        constraints: BoxConstraints(
          maxWidth: _maxWidth,
        ),
        decoration: BoxDecoration(
          color: _messageBubbleColor(context),
          borderRadius: _textBubbleBorderRadius(context),
        ),
        child: Padding(
          padding: const EdgeInsets.all(PaddingDimension.medium),
          child: _displayedText(context),
        ),
      );

  // Returns text from message, if it's provided
  // If it,s not, text is taken from [_messageText] parameter
  Widget _displayedText(BuildContext context) => SelectableText(
        _message?.text ?? _messageText ?? '',
        style: _textBubbleTextStyle(context),
      );

  BorderRadius _textBubbleBorderRadius(BuildContext context) =>
      BorderRadius.only(
        topLeft: const Radius.circular(_bubbleRadius),
        topRight: const Radius.circular(_bubbleRadius),
        bottomLeft: _fromCurrentUser
            ? const Radius.circular(_bubbleRadius)
            : Radius.zero,
        bottomRight: _fromCurrentUser
            ? Radius.zero
            : const Radius.circular(_bubbleRadius),
      );

  TextStyle _textBubbleTextStyle(BuildContext context) =>
      context.theme.textTheme.bodyText1!.copyWith(
        color: _textColor(context),
      );

  Color _textColor(BuildContext context) =>
      !_fromCurrentUser ? ColorPalette.white : ColorPalette.black;

  Color _messageBubbleColor(BuildContext context) => !_fromCurrentUser
      ? ColorPalette.blueLight.withOpacity(0.9)
      : ColorPalette.grayLight.withOpacity(0.7);
}
