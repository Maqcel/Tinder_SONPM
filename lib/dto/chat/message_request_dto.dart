import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message_request_dto.g.dart';

@JsonSerializable(createFactory: false)
class MessageRequestDTO {
  @JsonKey(name: 'messageText')
  final String messageText;

  @TimestampConverter()
  final DateTime sentAt;

  @JsonKey(name: 'sentBy')
  final String sentBy;

  MessageRequestDTO({
    required this.messageText,
    required this.sentAt,
    required this.sentBy,
  });

  Map<String, dynamic> toJson() => _$MessageRequestDTOToJson(this);
}

class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp timestamp) {
    return timestamp.toDate();
  }

  @override
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date);
}
