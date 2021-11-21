import 'package:equatable/equatable.dart';

class Match extends Equatable {
  final String name;
  final int age;
  final String photoUrl;

  const Match({
    required this.name,
    required this.age,
    required this.photoUrl,
  });

  @override
  List<Object> get props => [
        name,
        age,
        photoUrl,
      ];
}
