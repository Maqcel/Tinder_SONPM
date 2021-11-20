import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:tinder/domain/common/failure.dart';
import 'package:tinder/domain/model/user/user_profile.dart';
import 'package:tinder/domain/repositories/auth_repository.dart';
import 'package:tinder/domain/repositories/chat_repository.dart';
import 'package:tinder/domain/repositories/user_repository.dart';

part 'profile_screen_state.dart';

class ProfileScreenCubit extends Cubit<ProfileScreenState> {
  final UserRepository _userRepository;
  final AuthRepository _authRepository;

  ProfileScreenCubit({
    required UserRepository userRepository,
    required AuthRepository authRepository,
  })  : _userRepository = userRepository,
        _authRepository = authRepository,
        super(ProfileLoading());

  Future<void> onScreenOpened() async => await _loadUserProfile();

  Future<void> _loadUserProfile() async => emit(
        ProfileLoaded(
          profile: await _userRepository.getUserProfile(
            _authRepository.getCurrentUserUid(),
          ),
        ),
      );
}
