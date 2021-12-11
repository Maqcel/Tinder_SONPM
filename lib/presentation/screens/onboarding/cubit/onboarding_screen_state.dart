part of 'onboarding_screen_cubit.dart';

abstract class OnboardingScreenState extends Equatable {
  final bool onboardingCompleted;

  const OnboardingScreenState({required this.onboardingCompleted});

  @override
  List<Object?> get props => [onboardingCompleted];
}

class OnboardingInitial extends OnboardingScreenState {
  const OnboardingInitial() : super(onboardingCompleted: false);
}

class OnboardingStatus extends OnboardingScreenState {
  final String userName;
  final DateTime? birthDate;
  final Gender? gender;
  final List<Passions> passions;
  final String userBio;

  const OnboardingStatus({
    required bool onboardingCompleted,
    required this.userName,
    this.birthDate,
    this.gender,
    required this.passions,
    required this.userBio,
  }) : super(onboardingCompleted: onboardingCompleted);

  OnboardingStatus copyWith({
    bool? onboardingCompleted,
    String? userName,
    DateTime? birthDate,
    Gender? gender,
    List<Passions>? passions,
    String? userBio,
  }) =>
      OnboardingStatus(
        onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
        userName: userName ?? this.userName,
        birthDate: birthDate ?? this.birthDate,
        gender: gender ?? this.gender,
        passions: passions ?? this.passions,
        userBio: userBio ?? this.userBio,
      );

  @override
  List<Object?> get props => [
        userBio,
        userName,
        birthDate,
        gender,
        passions,
      ];
}

class OnboardingInProgress extends OnboardingScreenState {
  const OnboardingInProgress() : super(onboardingCompleted: false);
}
