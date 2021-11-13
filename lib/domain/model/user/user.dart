import 'package:equatable/equatable.dart';
import 'package:tinder/dto/user/user_response_dto.dart';

class User extends Equatable {
  final String uid;
  final String name;
  final String photoUrl;

  const User({
    required this.uid,
    required this.name,
    required this.photoUrl,
  });

  factory User.fromDto(UserResponseDTO dto) => User(
        uid: dto.uid,
        name: dto.name,
        photoUrl: dto.photoUrl,
      );

  @override
  List<Object> get props => [
        uid,
        name,
        photoUrl,
      ];
}
