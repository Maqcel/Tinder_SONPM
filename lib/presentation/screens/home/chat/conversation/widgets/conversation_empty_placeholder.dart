import 'package:flutter/material.dart';
import 'package:tinder/config/dimensions/padding_dimension.dart';
import 'package:tinder/extensions/build_context_extension.dart';

class ConversationEmptyPlaceholder extends StatelessWidget {
  final String _name;
  final String _photoUrl;

  const ConversationEmptyPlaceholder({
    Key? key,
    required String name,
    required String photoUrl,
  })  : _name = name,
        _photoUrl = photoUrl,
        super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _titleText(context),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: PaddingDimension.medium),
            child: _matchImage(context),
          ),
          _bodyText(context),
        ],
      );

  Widget _titleText(BuildContext context) => RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: context.theme.textTheme.headline1
              ?.copyWith(fontWeight: FontWeight.w400),
          children: [
            TextSpan(
              text: context.localizations.chatMatchesNoMessagesTitleText,
            ),
            TextSpan(
              text: _name,
              style: context.theme.textTheme.headline1,
            ),
          ],
        ),
      );

  Widget _matchImage(BuildContext context) => ClipRRect(
        borderRadius:
            BorderRadius.circular(MediaQuery.of(context).size.width / 2),
        child: Image.network(
          _photoUrl,
          fit: BoxFit.fill,
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.width / 2,
        ),
      );

  Widget _bodyText(BuildContext context) => Text(
        context.localizations.chatMatchesNoMessagesBodyText,
        style: context.theme.textTheme.bodyText1,
      );
}
