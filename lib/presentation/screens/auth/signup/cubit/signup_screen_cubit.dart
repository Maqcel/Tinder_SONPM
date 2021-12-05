import 'package:dartz/dartz.dart';
import 'package:email_validator/email_validator.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinder/domain/common/failure.dart';
import 'package:tinder/domain/repositories/user_repository.dart';

part 'signup_screen_state.dart';

class SignupScreenCubit extends Cubit<SignupScreenState> {
  final UserRepository _userRepository;

  SignupScreenCubit({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(const SignupScreenInitial());

  void onSignupDataChanged(String email, String password) =>
      emit(SignupDataChanged(
        allowSignup: EmailValidator.validate(email) && password.isNotEmpty,
      ));

  Future<void> onSignupButtonClicked(String email, String password) async {
    emit(const SignupInProgress());
    Either<Failure, UserCredential> result = await _userRepository.signup(
      email: email,
      password: password,
    );

    result.fold(
      (error) => emit(SignupError(
        failure: error,
      )),
      (data) => emit(const SignupSuccess()),
    );
  }
}
