import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinder/extensions/build_context_extension.dart';
import 'package:tinder/gen/assets.gen.dart';
import 'package:tinder/presentation/app/navigation/cubit/user_session_navigation_cubit.dart';
import 'package:tinder/presentation/screens/auth/login/cubit/login_screen_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) =>
      BlocConsumer<LoginScreenCubit, LoginScreenState>(
        builder: (context, state) => _body(state),
        listener: (context, state) => _onStateChanged(state),
      );

  final ButtonStyle createAccountButtonStyles = ElevatedButton.styleFrom(
    primary: Colors.white,
    onPrimary: Colors.black,
    minimumSize: const Size(500, 50),
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(50)),
        side: BorderSide(width: 1, color: Colors.white)),
  );

  final ButtonStyle signInButtonStyles = OutlinedButton.styleFrom(
    primary: Colors.white,
    minimumSize: const Size(500, 50),
    side: const BorderSide(
      width: 1.0,
      color: Colors.white,
    ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(50)),
    ),
  );

  Widget _title() {
    return Padding(
      padding: const EdgeInsets.only(top: 200),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 100),
            child: Assets.images.icons.tinderWhite
                .svg(color: Colors.white, width: 75, height: 75),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: Text(
              context.localizations.appName,
              style: const TextStyle(fontSize: 55, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  Widget _policy() {
    return (Container(
      margin: const EdgeInsets.only(top: 120, bottom: 35),
      child: Text(
        context.localizations.policyText,
        style: const TextStyle(color: Colors.white),
      ),
    ));
  }

  Widget _createAccountButton() {
    return (Container(
      margin: const EdgeInsets.only(bottom: 20, right: 10, left: 10),
      child: ElevatedButton(
        onPressed: () {},
        child: Text(context.localizations.createAccountButton),
        style: createAccountButtonStyles,
      ),
    ));
  }

  Widget _signInButton() {
    return (Container(
      margin: const EdgeInsets.only(bottom: 20, right: 10, left: 10),
      child: OutlinedButton(
          onPressed: _onLoginButtonClicked,
          child: Text(context.localizations.signInButton),
          style: signInButtonStyles),
    ));
  }

  Widget _body(LoginScreenState state) => Scaffold(
        backgroundColor: const Color.fromRGBO(255, 87, 100, 1),
        body: Column(
          children: [
            _title(),
            _policy(),
            _createAccountButton(),
            _signInButton(),
          ],
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
      // TODO: Implement error handling
    }
  }
}
