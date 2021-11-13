import 'package:json_annotation/json_annotation.dart';

part 'user_chats_response_dto.g.dart';

@JsonSerializable(createToJson: false)
class UserChatsResponseDTO {
  @JsonKey(name: 'matches', defaultValue: [])
  final List<String> matches;

  UserChatsResponseDTO({required this.matches});

  factory UserChatsResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$UserChatsResponseDTOFromJson(json);
}
