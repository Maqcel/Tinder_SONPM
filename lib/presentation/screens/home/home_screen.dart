import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinder/extensions/build_context_extension.dart';
import 'package:tinder/presentation/app/navigation/cubit/user_session_navigation_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _testLogOut(context),
      child: Scaffold(
        backgroundColor: Colors.blueAccent,
        body: Center(
          child: Text(
            context.localizations.homeText,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  // FIXME: Remove this just temporary demo
  Future<void> _testLogOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    context.read<UserSessionNavigationCubit>().onUserSessionStateChanged();
  }
}
