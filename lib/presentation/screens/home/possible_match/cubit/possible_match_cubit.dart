import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinder/domain/model/possible_match/possible_match.dart';
import 'package:tinder/domain/repositories/auth_repository.dart';
import 'package:tinder/domain/repositories/user_repository.dart';
import 'package:tinder/presentation/screens/home/possible_match/cubit/possible_match_state.dart';

class PossibleMatchScreenCubit extends Cubit<PossibleMatchState> {
  final UserRepository _userRepository;
  final AuthRepository _authRepository;

  PossibleMatchScreenCubit({required UserRepository userRepository,required AuthRepository authRepository})
      : _userRepository = userRepository,
        _authRepository = authRepository,
        super(PossibleMatchPlanLoading());

  Future<void> onScreenOpened() async {
    if (state is PossibleMatchPlanLoaded) {
      await _refreshProgram(state as PossibleMatchPlanLoaded);
    } else {
      await _loadMatches();
    }
  }

  Future<void> _refreshProgram(PossibleMatchPlanLoaded currentState) async {
    List<PossibleMatch> possibleMatches =
        (await _userRepository.getPossibleMatches(_authRepository.getCurrentUserUid()));
    List<PossibleMatch> topPicks =
        (await _userRepository.getTopPicks(_authRepository.getCurrentUserUid()));

    emit(currentState.copyWith(
      possibleMatches: possibleMatches,
      topPicks: topPicks,
    ));
  }

  Future<void> _loadMatches() async {
    List<PossibleMatch> possibleMatches =
        (await _userRepository.getPossibleMatches(_authRepository.getCurrentUserUid()));
    List<PossibleMatch> topPicks =
        (await _userRepository.getTopPicks(_authRepository.getCurrentUserUid()));

    emit(PossibleMatchPlanLoaded(
        possibleMatches: possibleMatches, topPicks: topPicks));
  }
}
