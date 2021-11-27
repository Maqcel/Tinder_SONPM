import 'package:equatable/equatable.dart';
import 'package:tinder/dto/possible_matches/possible_matches_resposnse_dto.dart';


class PossibleMatch extends Equatable {
  final String uid;
  final String name;
  final String photoUrl;
  final DateTime birth_date;

  const PossibleMatch({
    required this.uid,
    required this.name,
    required this.photoUrl,
    required this.birth_date
  });

  factory PossibleMatch.fromDto(PossibleMatchesResponseDTO dto) => PossibleMatch(
    uid: dto.uid,
    name: dto.name,
    photoUrl: dto.photoUrl,
    birth_date: dto.birth_date,
  );

  @override
  List<Object> get props => [
    uid,
    name,
    photoUrl,
    birth_date,
  ];
}
