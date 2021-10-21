import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:email_validator/email_validator.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tinder/domain/common/failure.dart';
import 'package:tinder/domain/repositories/user_repository.dart';

part 'login_screen_state.dart';

class LoginScreenCubit extends Cubit<LoginScreenState> {
  final UserRepository _userRepository;

  LoginScreenCubit({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(const LoginScreenInitial());

  Future<void> onLoginButtonClicked(String email, String password) async {
    emit(const LoginInProgress());
    Either<Failure, UserCredential> result = await _userRepository.login(
      email: email,
      password: password,
    );

    result.fold(
      (error) => emit(LoginError(
        failure: error,
      )),
      (data) => emit(const LoginSuccess()),
    );
  }
}
