import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinder/extensions/build_context_extension.dart';
import 'package:tinder/presentation/app/navigation/cubit/user_session_navigation_cubit.dart';
import 'package:tinder/presentation/common/screen_failure_handler.dart';
import 'package:tinder/presentation/screens/auth/login/cubit/login_screen_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with ScreenFailureHandler {
  @override
  Widget build(BuildContext context) =>
      BlocConsumer<LoginScreenCubit, LoginScreenState>(
        builder: (context, state) => _body(state),
        listener: (context, state) => _onStateChanged(state),
      );

  // TODO: Implement content
  Widget _body(LoginScreenState state) => GestureDetector(
        onTap: _onLoginButtonClicked,
        child: Scaffold(
          backgroundColor: Colors.yellow,
          body: Center(child: Text(context.localizations.loginText)),
        ),
      );

  // FIXME: Temporary method
  void _onLoginButtonClicked() {
    String email = 'test@test.com';
    String password = 'qwerty123';
    context.focusScope.unfocus();
    context.read<LoginScreenCubit>().onLoginButtonClicked(email, password);
  }

  void _onStateChanged(LoginScreenState state) {
    if (state is LoginSuccess) {
      context.read<UserSessionNavigationCubit>().onUserSessionStateChanged();
    } else if (state is LoginError) {
      handleFailureInUi(context: context, failure: state.failure);
    }
  }
}
