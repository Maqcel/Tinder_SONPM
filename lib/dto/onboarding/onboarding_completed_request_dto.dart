import 'package:json_annotation/json_annotation.dart';
import 'package:tinder/dto/chat/message_request_dto.dart';

part 'onboarding_completed_request_dto.g.dart';

@JsonSerializable(createFactory: false)
class OnboardingCompletedRequestDTO {
  final String name;

  @TimestampConverter()
  final DateTime birth_date;

  final List<String> passions;

  final String gender;

  final String bio;

  OnboardingCompletedRequestDTO({
    required this.name,
    required this.birth_date,
    required this.passions,
    required this.gender,
    required this.bio,
  });

  Map<String, dynamic> toJson() => _$OnboardingCompletedRequestDTOToJson(this);
}
