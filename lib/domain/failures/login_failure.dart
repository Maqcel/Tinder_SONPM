import 'package:tinder/domain/common/failure.dart';

class LoginFailure extends Failure {
  const LoginFailure({
    required String? errorMessage,
  }) : super(
          message: errorMessage,
        );
}
