import 'package:collection/collection.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as flyer;
import 'package:tinder/domain/model/chat/chat.dart';

import 'message_presentation.dart';

class FlyerChatDataProvider {
  final flyer.User _user;
  final flyer.User _match;

  FlyerChatDataProvider({
    required Chat chat,
  })  : _user = _readUser(chat),
        _match = _readMatch(chat);

  static flyer.User _readUser(Chat chat) => flyer.User(
        id: chat.user.uid,
        firstName: chat.user.name,
        imageUrl: chat.user.photoUrl,
      );

  static flyer.User _readMatch(Chat chat) => flyer.User(
        id: chat.match.uid,
        firstName: chat.match.name,
        imageUrl: chat.match.photoUrl,
      );

  static flyer.Status _readStatus(MessageStatus status) {
    switch (status) {
      case MessageStatus.sent:
        return flyer.Status.sent;
      case MessageStatus.sending:
        return flyer.Status.sending;
      case MessageStatus.error:
        return flyer.Status.error;
    }
  }

  flyer.User get currentUser => _user;

  List<flyer.Message> mapMessages(List<MessagePresentation> messages) =>
      messages
          .sorted((a, b) => b.createdAt.compareTo(a.createdAt))
          .map((message) => _mapMessage(message))
          .whereNotNull()
          .toList();

  flyer.TextMessage _mapMessage(MessagePresentation message) =>
      flyer.TextMessage(
        id: message.localId,
        remoteId: message.remoteId,
        author: message.isUsersMessage ? _user : _match,
        text: message.messageText,
        status: _readStatus(message.status),
        createdAt: message.createdAt.millisecondsSinceEpoch,
        updatedAt: message.createdAt.millisecondsSinceEpoch,
      );
}
