import 'package:equatable/equatable.dart';
import 'package:tinder/dto/user/user_profile_response_dto.dart';

class UserProfile extends Equatable {
  final String uid;
  final String name;
  final String photoUrl;
  final DateTime birthDate;

  const UserProfile({
    required this.uid,
    required this.name,
    required this.photoUrl,
    required this.birthDate,
  });

  factory UserProfile.fromDto(UserProfileDTO dto) => UserProfile(
        uid: dto.uid,
        name: dto.name,
        photoUrl: dto.photoUrl,
        birthDate: dto.birth_date,
      );

  @override
  List<Object> get props => [
        uid,
        name,
        photoUrl,
        birthDate,
      ];
}
