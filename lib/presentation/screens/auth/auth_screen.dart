import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinder/domain/repositories/user_repository.dart';
import 'package:tinder/extensions/build_context_extension.dart';
import 'package:tinder/presentation/screens/auth/login/cubit/login_screen_cubit.dart';
import 'package:tinder/presentation/screens/auth/navigation/auth_router.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final AuthRouter _routerDelegate = AuthRouter();
  ChildBackButtonDispatcher? _backButtonDispatcher;

  @override
  void didChangeDependencies() {
    _initBackButtonDispatcher();
    super.didChangeDependencies();
  }

  void _initBackButtonDispatcher() {
    _backButtonDispatcher ??=
        ChildBackButtonDispatcher(context.router.backButtonDispatcher!);
    _backButtonDispatcher?.takePriority();
  }

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => LoginScreenCubit(
                    userRepository: context.read<UserRepository>(),
                  ))
        ],
        child: Router(
          routerDelegate: _routerDelegate,
          backButtonDispatcher: _backButtonDispatcher,
        ),
      );
}
