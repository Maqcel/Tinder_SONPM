import 'package:json_annotation/json_annotation.dart';

part 'user_response_dto.g.dart';

@JsonSerializable(createToJson: false)
class UserResponseDTO {
  @JsonKey(name: 'uid')
  final String uid;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'photoUrl')
  final String photoUrl;

  UserResponseDTO({
    required this.uid,
    required this.name,
    required this.photoUrl,
  });

  factory UserResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$UserResponseDTOFromJson(json);
}
