import 'package:json_annotation/json_annotation.dart';
import 'package:tinder/dto/user/user_response_dto.dart';

part 'chat_response_dto.g.dart';

@JsonSerializable(createToJson: false, ignoreUnannotated: true)
class ChatResponseDTO {
  // This needs to be that way to not generate json conversion
  String? id;

  @JsonKey(name: 'chatters')
  final ChattersWrapperDTO chatters;

  ChatResponseDTO({
    this.id,
    required this.chatters,
  });

  factory ChatResponseDTO.fromFirestore(
    String documentId,
    Map<String, dynamic> json,
  ) =>
      ChatResponseDTO._fromJson(json)..id = documentId;

  factory ChatResponseDTO._fromJson(Map<String, dynamic> json) =>
      _$ChatResponseDTOFromJson(json);
}

@JsonSerializable(createToJson: false)
class ChattersWrapperDTO {
  @JsonKey(name: 'pair')
  final List<UserResponseDTO> chatters;

  ChattersWrapperDTO({required this.chatters});

  factory ChattersWrapperDTO.fromJson(Map<String, dynamic> json) =>
      _$ChattersWrapperDTOFromJson(json);
}
