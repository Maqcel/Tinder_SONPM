import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinder/domain/model/possible_match/possible_match.dart';
import 'package:tinder/domain/repositories/user_repository.dart';
import 'package:tinder/presentation/screens/home/possible_match/cubit/possible_match_state.dart';

class PossibleMatchScreenCubit extends Cubit<PossibleMatchState> {
  final UserRepository _userRepository;

  PossibleMatchScreenCubit({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(PossibleMatchPlanLoading());

  Future<void> onScreenOpened() async {
    if (state is PossibleMatchPlanLoaded) {
      await _refreshProgram(state as PossibleMatchPlanLoaded);
    } else {
      await _loadMatches();
    }
  }

  Future<void> _refreshProgram(PossibleMatchPlanLoaded currentState) async {
    // TODO: change to correct function from userRepository
    List<PossibleMatch> possibleMatches =
        (await _userRepository.getUserProfile("1")) as List<PossibleMatch>;
    List<PossibleMatch> topPicks =
        (await _userRepository.getUserProfile("2")) as List<PossibleMatch>;

    emit(currentState.copyWith(
      possibleMatches: possibleMatches,
      topPicks: topPicks,
    ));
  }

  Future<void> _loadMatches() async {
    // TODO: change to correct function from userRepository
    List<PossibleMatch> possibleMatches =
        (await _userRepository.getUserProfile("1")) as List<PossibleMatch>;
    List<PossibleMatch> topPicks =
        (await _userRepository.getUserProfile("2")) as List<PossibleMatch>;

    emit(PossibleMatchPlanLoaded(
        possibleMatches: possibleMatches, topPicks: topPicks));
  }
}
