import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinder/presentation/app/navigation/cubit/user_session_navigation_cubit.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: Future<dynamic>.delayed(
          const Duration(seconds: 1),
          () => context
              .read<UserSessionNavigationCubit>()
              .onUserSessionStateChanged(),
        ),
        builder: (context, snapshot) => _body(context),
      );

  Widget _body(BuildContext context) => Scaffold(
        body: Container(
          alignment: Alignment.center,
          color: Colors.blue,
          child: const FractionallySizedBox(
            heightFactor: 1,
            widthFactor: 0.5,
            child: FlutterLogo(),
          ),
        ),
      );
}
