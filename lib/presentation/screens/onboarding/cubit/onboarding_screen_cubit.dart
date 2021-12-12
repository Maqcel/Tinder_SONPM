import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tinder/domain/model/onboarding/gender.dart';
import 'package:tinder/domain/model/onboarding/passions.dart';
import 'package:tinder/domain/repositories/onboarding_repository.dart';
import 'package:tinder/dto/onboarding/onboarding_completed_request_dto.dart';

part 'onboarding_screen_state.dart';

class OnboardingScreenCubit extends Cubit<OnboardingScreenState> {
  final OnboardingRepository _onboardingRepository;
  OnboardingScreenCubit({required OnboardingRepository onboardingRepository})
      : _onboardingRepository = onboardingRepository,
        super(const OnboardingInitial());

  void initOnboarding() => emit(const OnboardingStatus(
        onboardingCompleted: false,
        userName: '',
        passions: [],
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

  void changePassions(Passions passion) {
    OnboardingStatus current = state as OnboardingStatus;
    List<Passions> currentPassions = [...current.passions];
    if (current.passions.contains(passion)) {
      currentPassions.remove(passion);
    } else {
      currentPassions.add(passion);
    }
    if (current.gender != null &&
        current.userBio.isNotEmpty &&
        current.passions.isNotEmpty &&
        current.userName.isNotEmpty &&
        current.birthDate != null) {
      emit(current.copyWith(
          passions: currentPassions, onboardingCompleted: true));
    } else {
      emit(current.copyWith(
          passions: currentPassions, onboardingCompleted: false));
    }
  }

  void changeOnboardingPersonalData(String userBio, String userName) {
    OnboardingStatus current = state as OnboardingStatus;
    if (current.gender != null &&
        current.userBio.isNotEmpty &&
        current.passions.isNotEmpty &&
        current.userName.isNotEmpty &&
        current.birthDate != null) {
      emit(current.copyWith(
        userBio: userBio,
        userName: userName,
        onboardingCompleted: true,
      ));
    } else {
      emit(current.copyWith(
        userBio: userBio,
        userName: userName,
        onboardingCompleted: false,
      ));
    }
  }

  void chooseGenderData(Gender gender) {
    OnboardingStatus current = state as OnboardingStatus;
    if (current.userBio.isNotEmpty &&
        current.passions.isNotEmpty &&
        current.userName.isNotEmpty &&
        current.birthDate != null) {
      emit(current.copyWith(
        gender: gender,
        onboardingCompleted: true,
      ));
    } else {
      emit(current.copyWith(
        gender: gender,
        onboardingCompleted: false,
      ));
    }
  }

  Future<void> finishOnboarding(OnboardingStatus state) async {
    _onboardingRepository.completeOnboarding(OnboardingCompletedRequestDTO(
      name: state.userName,
      birth_date: state.birthDate!,
      passions:
          state.passions.map((passion) => passion.toValueString()).toList(),
      gender: state.gender!.toValueString(),
      bio: state.userBio,
    ));
    emit(const OnboardingInProgress());
  }
}
