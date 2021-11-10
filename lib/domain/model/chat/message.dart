import 'package:equatable/equatable.dart';
import 'package:tinder/dto/chat/message_response_dto.dart';

class Message extends Equatable {
  final String id;
  final String messageText;
  final DateTime sentAt;
  final String sentBy;

  const Message({
    required this.id,
    required this.messageText,
    required this.sentAt,
    required this.sentBy,
  });

  factory Message.fromDto(MessageResponseDTO dto) => Message(
        id: dto.id!,
        messageText: dto.messageText,
        sentAt: dto.sentAt,
        sentBy: dto.sentBy,
      );

  @override
  List<Object> get props => [
        id,
        messageText,
        sentAt,
        sentBy,
      ];
}
