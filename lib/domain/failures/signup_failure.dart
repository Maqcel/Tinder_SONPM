import 'package:tinder/domain/common/failure.dart';

class SignupFailure extends Failure {
  const SignupFailure({
    required String? errorMessage,
  }) : super(
          message: errorMessage,
        );
}
