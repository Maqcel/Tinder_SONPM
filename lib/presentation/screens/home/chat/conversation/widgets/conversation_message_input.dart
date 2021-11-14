import 'package:flutter/material.dart';
import 'package:tinder/config/dimensions/padding_dimension.dart';
import 'package:tinder/config/dimensions/radius_dimension.dart';
import 'package:tinder/extensions/build_context_extension.dart';

class ConversationMessageInput extends StatelessWidget {
  final bool _isSendButtonEnabled;
  final TextEditingController? _controller;
  final Function()? _onSendButtonClicked;

  const ConversationMessageInput({
    Key? key,
    required bool isSendButtonEnabled,
    TextEditingController? controller,
    Function()? onSendButtonClicked,
  })  : _isSendButtonEnabled = isSendButtonEnabled,
        _controller = controller,
        _onSendButtonClicked = onSendButtonClicked,
        super(key: key);

  @override
  Widget build(BuildContext context) => SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: PaddingDimension.small,
          horizontal: PaddingDimension.medium,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _input(context),
            const SizedBox(width: PaddingDimension.small),
            _sendButton(context),
          ],
        ),
      ));

  Widget _input(BuildContext context) => Expanded(
        child: TextField(
          controller: _controller,
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          minLines: 1,
          maxLines: 4,
          autocorrect: true,
          style: context.theme.textTheme.caption,
          decoration: _inputDecoration(context),
        ),
      );

  InputDecoration _inputDecoration(BuildContext context) => InputDecoration(
        isDense: true,
        hintText: context.localizations.chatConversationInputHintText,
        contentPadding: const EdgeInsets.all(PaddingDimension.medium),
        hintStyle: _inputHintStyle(context),
        border: _inputIdleBorder(context),
        focusedBorder: _inputFocusedBorder(context),
      );

  TextStyle? _inputHintStyle(BuildContext context) =>
      context.theme.textTheme.caption?.copyWith(
        color: context.theme.hintColor,
      );

  BorderRadius _inputBorderRadius() => const BorderRadius.only(
        topLeft: RadiusDimension.circularLarge,
        topRight: RadiusDimension.circularLarge,
        bottomLeft: RadiusDimension.circularLarge,
      );

  InputBorder _inputIdleBorder(BuildContext context) => OutlineInputBorder(
        borderRadius: _inputBorderRadius(),
        borderSide: BorderSide(
          width: 1,
          color: context.theme.hintColor,
        ),
      );

  InputBorder _inputFocusedBorder(BuildContext context) => OutlineInputBorder(
        borderRadius: _inputBorderRadius(),
        borderSide: BorderSide(
          width: 1.5,
          color: context.theme.hintColor,
        ),
      );

  Widget _sendButton(BuildContext context) => ElevatedButton(
        child: _sendButtonContent(context),
        style: ButtonStyle(
          // Minimum size set to 0 to drop material padding
          minimumSize: MaterialStateProperty.all(Size.zero),
          padding: _sendButtonPadding(context),
          elevation: _sendButtonElevation(),
          backgroundColor: _sendButtonBackgroundColor(context),
          shape: _sendButtonShape(context),
        ),
        onPressed: _isSendButtonEnabled ? _onSendButtonClicked : null,
      );

  Widget _sendButtonContent(BuildContext context) => const Icon(Icons.send);

  MaterialStateProperty<EdgeInsets> _sendButtonPadding(BuildContext context) =>
      MaterialStateProperty.all(
        const EdgeInsets.all(PaddingDimension.medium),
      );

  MaterialStateProperty<double> _sendButtonElevation() =>
      MaterialStateProperty.all(0);

  MaterialStateProperty<Color> _sendButtonBackgroundColor(
          BuildContext context) =>
      MaterialStateProperty.all(_isSendButtonEnabled
          ? context.theme.colorScheme.primary
          : context.theme.disabledColor);

  MaterialStateProperty<OutlinedBorder> _sendButtonShape(
          BuildContext context) =>
      MaterialStateProperty.all(const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: RadiusDimension.circularLarge,
          bottomRight: RadiusDimension.circularLarge,
        ),
      ));
}
