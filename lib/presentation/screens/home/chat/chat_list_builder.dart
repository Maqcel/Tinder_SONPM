import 'package:flutter/material.dart';
import 'package:tinder/domain/model/chat/chat.dart';
import 'package:tinder/presentation/screens/home/chat/widgets/swiping_cards_placeholder.dart';

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
              children: [],
            );
}
