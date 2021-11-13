import 'package:equatable/equatable.dart';
import 'package:tinder/domain/model/chat/message.dart';
import 'package:uuid/uuid.dart';

enum MessageStatus {
  sent,
  sending,
  error,
}

class MessagePresentation extends Equatable {
  final String? remoteId;
  final String localId;
  final bool isUsersMessage;
  final String messageText;
  final DateTime createdAt;
  final MessageStatus status;

  const MessagePresentation({
    required this.remoteId,
    required this.localId,
    required this.isUsersMessage,
    required this.messageText,
    required this.createdAt,
    required this.status,
  });

  factory MessagePresentation.fromExistingMessage(
    Message message, {
    bool skipFile = false,
    bool skipBody = false,
    required bool isUsersMessage,
  }) =>
      MessagePresentation(
        remoteId: message.id,
        localId: const Uuid().v4().toString(),
        isUsersMessage: isUsersMessage,
        messageText: skipBody ? '' : message.messageText,
        createdAt: message.sentAt,
        status: MessageStatus.sent,
      );

  factory MessagePresentation.newLocalMessage(String messageBody) =>
      MessagePresentation(
        remoteId: null,
        localId: const Uuid().v4().toString(),
        isUsersMessage: true,
        messageText: messageBody,
        createdAt: DateTime.now(),
        status: MessageStatus.sending,
      );

  MessagePresentation copyWith({
    String? remoteId,
    String? localId,
    bool? isUsersMessage,
    String? messageText,
    bool? isRead,
    DateTime? createdAt,
    MessageStatus? status,
  }) =>
      MessagePresentation(
        remoteId: remoteId ?? this.remoteId,
        localId: localId ?? this.localId,
        isUsersMessage: isUsersMessage ?? this.isUsersMessage,
        messageText: messageText ?? this.messageText,
        createdAt: createdAt ?? this.createdAt,
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [
        remoteId,
        localId,
        isUsersMessage,
        messageText,
        createdAt,
        status,
      ];
}
