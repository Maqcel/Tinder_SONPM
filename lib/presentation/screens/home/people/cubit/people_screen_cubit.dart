import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tinder/domain/model/possible_match/possible_match.dart';
import 'package:tinder/domain/repositories/people_repository.dart';
import 'package:tinder/presentation/screens/home/people/swiping_direction.dart';

part 'people_screen_state.dart';

class PeopleScreenCubit extends Cubit<PeopleScreenState> {
  final PeopleRepository _peopleRepository;

  PeopleScreenCubit({required PeopleRepository peopleRepository})
      : _peopleRepository = peopleRepository,
        super(const PeopleLoading());

  Future<void> fetchData() async {
    if (state is PeopleLoading) {
      List<PossibleMatch> result = await _peopleRepository.fetchUsers();
      emit(PeopleLoaded(
        possibleMatches: result,
        dx: 0,
        swipingDirection: SwipingDirection.none,
        lastFetchedUid: result.last.uid,
      ));
    } else if (state is PeopleLoaded) {
      PeopleLoaded currentState = (state as PeopleLoaded);
      List<PossibleMatch> result = await _peopleRepository.fetchUsers(
        fetchAfterUid: currentState.lastFetchedUid,
      );
      emit(currentState.copyWith(
        possibleMatches: [
          ...result,
          ...currentState.possibleMatches,
        ],
        lastFetchedUid: result.isNotEmpty ? result.last.uid : '',
      ));
    }
  }

  void updateSwipingPosition(double currentDx) =>
      emit((state as PeopleLoaded).copyWith(
        dx: state.dx + currentDx,
        swipingDirection: state.dx + currentDx > 0
            ? SwipingDirection.right
            : state.dx + currentDx < 0
                ? SwipingDirection.left
                : SwipingDirection.none,
      ));

  void resetPosition() => emit((state as PeopleLoaded).copyWith(
        dx: 0,
        swipingDirection: SwipingDirection.none,
      ));

  Future<void> onLike(String possibleMatchUid) async {
    PeopleLoaded currentState = (state as PeopleLoaded);
    await _peopleRepository.createMatch(possibleMatchUid);
    emit(currentState.copyWith(
      possibleMatches: [...currentState.possibleMatches]..removeLast(),
    ));
  }

  Future<void> onDislike() async {
    emit((state as PeopleLoaded).copyWith(
      possibleMatches: [...(state as PeopleLoaded).possibleMatches]
        ..removeLast(),
    ));
    if ((state as PeopleLoaded).possibleMatches.length <= 2) {
      await fetchData();
    }
  }
}
