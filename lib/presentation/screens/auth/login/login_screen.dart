import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinder/extensions/build_context_extension.dart';
import 'package:tinder/presentation/app/navigation/cubit/user_session_navigation_cubit.dart';
import 'package:tinder/presentation/screens/auth/login/cubit/login_screen_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  // final String _assetName = 'assets/image.svg';
  // const Widget svg =
  //     SvgPicture.asset('assets/image.svg', semanticsLabel: 'Acme Logo');

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

  // TODO: Implement content
  Widget _body(LoginScreenState state) => GestureDetector(
        onTap: _onLoginButtonClicked,
        child: Scaffold(
            backgroundColor: const Color.fromRGBO(255, 87, 100, 1),
            body: Container(
              // TODO: how to center it properly
              margin: const EdgeInsets.only(left: 125, top: 300),
              child: Column(
                children: [
                  Row(
                    children: const [
                      // TODO: why this is not working?
                      // Image(image: AssetImage('tinder_white.svg')),
                      // TODO: change icon to tinder one
                      Icon(Icons.settings_display_sharp,
                          color: Colors.white, size: 55),
                      Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            "tinder",
                            style: TextStyle(fontSize: 55, color: Colors.white),
                          ))
                    ],
                  ),
                ],
              ),
            )),
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
