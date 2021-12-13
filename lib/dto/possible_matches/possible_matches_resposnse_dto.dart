import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tinder/dto/chat/message_request_dto.dart';

part 'possible_matches_resposnse_dto.g.dart';

@JsonSerializable(createToJson: false)
class PossibleMatchesResponseDTO {
  @JsonKey(name: 'uid')
  final String uid;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'bio')
  final String bio;

  @JsonKey(name: 'profile_photo_path')
  final String photoUrl;

  @TimestampConverter()
  final DateTime birth_date;

  PossibleMatchesResponseDTO({
    required this.uid,
    required this.name,
    required this.photoUrl,
    required this.birth_date,
    required this.bio,
  });

  factory PossibleMatchesResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$PossibleMatchesResponseDTOFromJson(json);
}