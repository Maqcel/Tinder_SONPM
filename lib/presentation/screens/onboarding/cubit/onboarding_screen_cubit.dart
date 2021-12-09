import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tinder/domain/model/onboarding/gender.dart';
import 'package:tinder/domain/model/onboarding/passions.dart';

part 'onboarding_screen_state.dart';

class OnboardingScreenCubit extends Cubit<OnboardingScreenState> {
  OnboardingScreenCubit() : super(const OnboardingInitial());

  void initOnboarding() => emit(OnboardingStatus(
        onboardingCompleted: false,
        userName: '',
        birthDate: DateTime.now(),
        passions: const [],
        userBio: '',
      ));

  void changeBirthDate(DateTime? date) {
    OnboardingStatus current = state as OnboardingStatus;
    if (current.gender != null &&
        current.userBio.isNotEmpty &&
        current.passions.isNotEmpty &&
        current.userName.isNotEmpty) {
      emit(current.copyWith(birthDate: date, onboardingCompleted: true));
    } else {
      emit(current.copyWith(birthDate: date, onboardingCompleted: false));
    }
  }
}
