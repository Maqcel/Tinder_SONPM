part of 'people_screen_cubit.dart';

abstract class PeopleScreenState extends Equatable {
  final double dx;
  final SwipingDirection swipingDirection;
  final String lastFetchedUid;

  const PeopleScreenState({
    required this.dx,
    required this.swipingDirection,
    required this.lastFetchedUid,
  });

  @override
  List<Object> get props => [
        dx,
        swipingDirection,
        lastFetchedUid,
      ];
}

class PeopleLoading extends PeopleScreenState {
  const PeopleLoading()
      : super(
          dx: 0,
          swipingDirection: SwipingDirection.none,
          lastFetchedUid: '',
        );
}

class PeopleLoaded extends PeopleScreenState {
  final List<PossibleMatch> possibleMatches;

  const PeopleLoaded({
    required this.possibleMatches,
    required double dx,
    required SwipingDirection swipingDirection,
    required String lastFetchedUid,
  }) : super(
          dx: dx,
          swipingDirection: swipingDirection,
          lastFetchedUid: lastFetchedUid,
        );

  PeopleLoaded copyWith({
    double? dx,
    SwipingDirection? swipingDirection,
    List<PossibleMatch>? possibleMatches,
    String? lastFetchedUid,
  }) =>
      PeopleLoaded(
        possibleMatches: possibleMatches ?? this.possibleMatches,
        dx: dx ?? this.dx,
        swipingDirection: swipingDirection ?? this.swipingDirection,
        lastFetchedUid: lastFetchedUid ?? this.lastFetchedUid,
      );

  @override
  List<Object> get props => [possibleMatches];
}
