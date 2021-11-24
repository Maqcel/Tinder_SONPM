part of 'profile_screen_cubit.dart';

abstract class ProfileScreenState extends Equatable {
  const ProfileScreenState();

  @override
  List<Object> get props => [];
}

class ProfileLoading extends ProfileScreenState {}

class ProfileLoaded extends ProfileScreenState {
  final UserProfile profile;

  const ProfileLoaded({required this.profile});

  @override
  List<Object> get props => [profile];
}

class ProfileLoadError extends ProfileScreenState {
  final Failure failure;

  const ProfileLoadError({required this.failure});

  @override
  List<Object> get props => [failure];
}
