import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinder/domain/common/failure.dart';
import 'package:tinder/domain/failures/authorization_failure.dart';
import 'package:tinder/domain/repositories/auth_repository.dart';
import 'package:tinder/presentation/app/navigation/cubit/user_session_navigation_cubit.dart';
import 'package:tinder/presentation/dialogs/unexpected_error_dialog.dart';

/// Mixin to handle common errors in presentation layer
/// Takes action based on type of provided failure
class ScreenFailureHandler {
  void handleFailureInUi({
    required BuildContext context,
    required Failure failure,
    Function()? onFailureAcknowledged,
  }) {
    if (failure is AuthorizationFailure) {
      handleAuthorizationFailure(context, failure);
    } else {
      handleUnexpectedFailure(
        context,
        onFailureAcknowledged: onFailureAcknowledged,
      );
    }
  }

  // If something went wrong user should be moved back to login
  Future<void> handleAuthorizationFailure(
    BuildContext buildContext,
    AuthorizationFailure failure,
  ) async {
    log(
      'Authorization failure, clearing session redirecting back to login',
      error: failure.cause,
    );
    buildContext.read<AuthRepository>().clearLocalUserSession();
    buildContext.read<UserSessionNavigationCubit>().onUserSessionStateChanged();
  }

  /// Shows dialog for [UnexpectedFailure]
  Future<void> handleUnexpectedFailure(
    BuildContext context, {
    Function()? onFailureAcknowledged,
  }) async {
    await showDialog(
      context: context,
      builder: (context) => UnexpectedErrorDialog(
        onDismiss: onFailureAcknowledged,
      ),
    );
  }
}
