import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinder/extensions/build_context_extension.dart';
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

  Widget _body(LoginScreenState state) => GestureDetector(
        onTap: _onLoginButtonClicked,
        child: Scaffold(
          backgroundColor: const Color.fromRGBO(255, 87, 100, 1),
          body: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                child: Row(
                  children: [
                    // TODO: why image is not working
                    // const Image(image: AssetImage('assets/images/icons/tinder_white.svg')),
                    Container(
                      margin: const EdgeInsets.only(left: 100, top: 200),
                      child: const Icon(Icons.settings_display_sharp,
                          color: Colors.white, size: 55),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10, top: 200),
                      child: const Text(
                        "tinder",
                        style: TextStyle(fontSize: 55, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 120, bottom: 35),
                child: Text(
                  context.localizations.policyText,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20, right: 10, left: 10),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(context.localizations.createAccountButton),
                  style: createAccountButtonStyles,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20, right: 10, left: 10),
                child: OutlinedButton(
                    onPressed: _onLoginButtonClicked,
                    child: Text(context.localizations.signInButton),
                    style: signInButtonStyles),
              ),
            ],
          ),
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
