import 'package:tinder/domain/common/failure.dart';

class AuthorizationFailure extends Failure {
  const AuthorizationFailure({String? message, Exception? cause})
      : super(message: message, cause: cause);
}
