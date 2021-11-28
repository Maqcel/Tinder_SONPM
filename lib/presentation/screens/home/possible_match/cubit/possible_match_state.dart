import 'package:equatable/equatable.dart';
import 'package:tinder/domain/common/failure.dart';
import 'package:tinder/domain/model/possible_match/possible_match.dart';

abstract class PossibleMatchState extends Equatable {
  const PossibleMatchState();

  @override
  List<Object> get props => [];
}

class PossibleMatchPlanLoading extends PossibleMatchState {}

class PossibleMatchPlanLoaded extends PossibleMatchState {
  final List<PossibleMatch> possibleMatches;
  final List<PossibleMatch> topPicks;

  const PossibleMatchPlanLoaded({
    required this.possibleMatches,
    required this.topPicks,
  });

  PossibleMatchPlanLoaded copyWith(
          {List<PossibleMatch>? possibleMatches,
          List<PossibleMatch>? topPicks}) =>
      PossibleMatchPlanLoaded(
          possibleMatches: possibleMatches ?? this.possibleMatches,
          topPicks: topPicks ?? this.topPicks);

  @override
  List<Object> get props => [possibleMatches, topPicks];
}

class PossibleMatchLoadError extends PossibleMatchState {
  final Failure failure;

  const PossibleMatchLoadError({required this.failure});

  @override
  List<Object> get props => [failure];
}
