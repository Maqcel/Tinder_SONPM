// This will create only fromJson method
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message_response_dto.g.dart';

@JsonSerializable(createToJson: false, ignoreUnannotated: true)
class MessageResponseDTO {
  // This needs to be that way to not generate json conversion
  String? id;

  @JsonKey(name: 'messageText')
  final String messageText;

  @JsonKey(fromJson: _dateTimeFromTimestamp)
  final DateTime sentAt;

  @JsonKey(name: 'sentBy')
  final String sentBy;

  MessageResponseDTO({
    this.id,
    required this.messageText,
    required this.sentAt,
    required this.sentBy,
  });

  factory MessageResponseDTO.fromFirestore(
    String documentId,
    Map<String, dynamic> json,
  ) =>
      MessageResponseDTO.fromJson(json)..id = documentId;

  factory MessageResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$MessageResponseDTOFromJson(json);

  static DateTime _dateTimeFromTimestamp(Timestamp timestamp) =>
      DateTime.parse(timestamp.toDate().toString());
}
