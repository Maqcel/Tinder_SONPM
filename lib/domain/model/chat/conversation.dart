import 'package:equatable/equatable.dart';
import 'package:tinder/domain/model/chat/chat.dart';
import 'package:tinder/domain/model/chat/message.dart';
import 'package:tinder/dto/chat/conversation_response_dto.dart';

class Conversation extends Equatable {
  final Chat chatData;
  final List<Message> messages;

  const Conversation({
    required this.chatData,
    required this.messages,
  });

  factory Conversation.fromDto(ConversationResponseDTO dto, String userUid) =>
      Conversation(
        chatData: Chat.fromDto(dto.chatData!, userUid),
        messages: dto.messages
            .map((messageDto) => Message.fromDto(messageDto))
            .toList(),
      );

  @override
  List<Object> get props => [
        chatData,
        messages,
      ];
}
