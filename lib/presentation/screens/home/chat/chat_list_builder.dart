import 'package:flutter/material.dart';
import 'package:tinder/config/dimensions/padding_dimension.dart';
import 'package:tinder/config/dimensions/radius_dimension.dart';
import 'package:tinder/config/theme/color_palette.dart';
import 'package:tinder/domain/model/chat/chat.dart';
import 'package:tinder/extensions/build_context_extension.dart';
import 'package:tinder/presentation/screens/home/chat/widgets/swiping_cards_placeholder.dart';
import 'package:tinder/presentation/widget/image/saved_state_cached_image.dart';

class ChatListBuilder {
  static Widget build({
    required BuildContext context,
    required List<Chat> chats,
    required Function(Chat) onChatClicked,
  }) =>
      chats.isEmpty
          ? const SwipingCardPlaceholder()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _headerText(
                  context,
                  context.localizations.chatHasMatchesNewMatchesText,
                ),
                _newMatchesChatsListView(
                  context,
                  chats
                      .where((element) => element.mostRecentMessage == null)
                      .toList(),
                  onChatClicked,
                ),
                _headerText(
                  context,
                  context.localizations.chatHasMatchesMatchesText,
                ),
                _matchesWithChatsList(
                  context,
                  chats
                      .where((element) => element.mostRecentMessage != null)
                      .toList(),
                  onChatClicked,
                ),
              ],
            );

  static Widget _headerText(BuildContext context, String text) => Padding(
        padding: const EdgeInsets.all(PaddingDimension.medium),
        child: Text(
          text,
          style: context.theme.textTheme.headline5?.copyWith(
            color: ColorPalette.colorPrimary100,
          ),
        ),
      );

  static Widget _newMatchesChatsListView(
    BuildContext context,
    List<Chat> chats,
    Function(Chat) onChatClicked,
  ) =>
      Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: PaddingDimension.medium),
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 5,
          width: MediaQuery.of(context).size.width,
          child: ListView.separated(
            itemCount: chats.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) =>
                _newMatchesChatTile(context, chats[index], onChatClicked),
            separatorBuilder: (_, __) =>
                const SizedBox(width: PaddingDimension.medium),
          ),
        ),
      );

  static Widget _newMatchesChatTile(
    BuildContext context,
    Chat chat,
    Function(Chat) onChatClicked,
  ) =>
      GestureDetector(
        onTap: () => onChatClicked(chat),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 6,
              width: 100,
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.all(RadiusDimension.circularSmall),
                child: SavedStateNetworkImage(
                  url: chat.match.photoUrl,
                  fit: BoxFit.fitHeight,
                  placeholder: (_, __) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
            Text(
              chat.match.name,
              style: context.theme.textTheme.headline5,
            )
          ],
        ),
      );

  static Widget _matchesWithChatsList(
    BuildContext context,
    List<Chat> chats,
    Function(Chat) onChatClicked,
  ) =>
      Column(
        children: chats
            .map((chat) => _matchesWitchChatsTile(context, chat, onChatClicked))
            .toList(),
      );

  static Widget _matchesWitchChatsTile(
    BuildContext context,
    Chat chat,
    Function(Chat) onChatClicked,
  ) =>
      InkWell(
        onTap: () => onChatClicked(chat),
        child: Padding(
          padding: const EdgeInsets.all(PaddingDimension.small),
          child: SizedBox(
            height: 80,
            child: Row(
              children: [
                _chatterRoundedIcon(chat.match.photoUrl),
                const SizedBox(width: PaddingDimension.medium),
                _chatterNameAndLastMessage(context, chat),
              ],
            ),
          ),
        ),
      );

  static Widget _chatterRoundedIcon(String url) => ClipRRect(
        borderRadius: BorderRadius.all(RadiusDimension.circularLarge * 2),
        child: SavedStateNetworkImage(
          url: url,
          fit: BoxFit.fitHeight,
          placeholder: (_, __) => const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );

  static Widget _chatterNameAndLastMessage(BuildContext context, Chat chat) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            chat.match.name,
            style: context.theme.textTheme.headline2,
          ),
          const SizedBox(height: PaddingDimension.small),
          Text(
            chat.mostRecentMessage!.messageText,
            style: context.theme.textTheme.bodyText1
                ?.copyWith(color: ColorPalette.grayLight),
          ),
        ],
      );
}
