import 'package:equatable/equatable.dart';
import 'package:tinder/dto/user/user_profile_response_dto.dart';

class UserProfile extends Equatable {
  final String uid;
  final String name;
  final String photoUrl;
  final DateTime birthDate;
  final String bio;

  const UserProfile({
    required this.uid,
    required this.name,
    required this.photoUrl,
    required this.birthDate,
    required this.bio,
  });

  factory UserProfile.fromDto(UserProfileDTO dto) => UserProfile(
        uid: dto.uid,
        name: dto.name,
        photoUrl: dto.photoUrl,
        birthDate: dto.birth_date,
        bio: dto.bio,
      );

  @override
  List<Object> get props => [
        uid,
        name,
        photoUrl,
        birthDate,
      ];
}
