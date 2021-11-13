import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tinder/dto/chat/chat_response_dto.dart';
import 'package:tinder/dto/chat/message_response_dto.dart';

part 'conversation_response_dto.g.dart';

@JsonSerializable(createToJson: false, ignoreUnannotated: true)
class ConversationResponseDTO {
  // This needs to be that way to not generate json conversion
  ChatResponseDTO? chatData;

  @JsonKey(fromJson: _messageListFromCollection, defaultValue: [])
  final List<MessageResponseDTO> messages;

  ConversationResponseDTO({
    this.chatData,
    required this.messages,
  });

  factory ConversationResponseDTO.fromFirestore(
    String documentId,
    Map<String, dynamic> json,
  ) =>
      ConversationResponseDTO._fromJson(json)
        ..chatData = _chatDataFromCollection(documentId, json);

  factory ConversationResponseDTO._fromJson(Map<String, dynamic> json) =>
      _$ConversationResponseDTOFromJson(json);

  static ChatResponseDTO _chatDataFromCollection(
    String documentId,
    Map<String, dynamic> json,
  ) =>
      ChatResponseDTO.fromFirestore(documentId, json);

  static List<MessageResponseDTO> _messageListFromCollection(
          List<DocumentSnapshot> documentSnapshots) =>
      documentSnapshots
          .map((e) => MessageResponseDTO.fromFirestore(
                e.id,
                e.data() as Map<String, dynamic>,
              ))
          .toList();
}
