import 'package:equatable/equatable.dart';
import 'package:tinder/dto/possible_matches/possible_matches_resposnse_dto.dart';

class PossibleMatch extends Equatable {
  final String uid;
  final String name;
  final String photoUrl;
  final DateTime birthDate;
  final String bio;

  const PossibleMatch(
      {required this.uid,
      required this.name,
      required this.photoUrl,
      required this.birthDate,
      required this.bio});

  factory PossibleMatch.fromDto(PossibleMatchesResponseDTO dto) =>
      PossibleMatch(
          uid: dto.uid,
          name: dto.name,
          photoUrl: dto.photoUrl,
          birthDate: dto.birth_date,
          bio: dto.bio);

  @override
  List<Object> get props => [uid, name, photoUrl, birthDate];
}
