import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinder/extensions/build_context_extension.dart';
import 'package:tinder/gen/assets.gen.dart';
import 'package:tinder/presentation/app/navigation/cubit/user_session_navigation_cubit.dart';

class PeopleScreen extends StatefulWidget {
  const PeopleScreen({Key? key}) : super(key: key);

  @override
  _PeopleScreenState createState() => _PeopleScreenState();
}

class _PeopleScreenState extends State<PeopleScreen> {
  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => _testLogOut(context),
        child: Scaffold(
          appBar: AppBar(
            leading:
                Assets.images.icons.tinderWhite.svg(color: Colors.pink[600]),
          ),
          body: Center(child: Text(context.localizations.homeText)),
          backgroundColor: Colors.blue,
        ),
      );

  // FIXME: Remove this just temporary demo
  Future<void> _testLogOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    context.read<UserSessionNavigationCubit>().onUserSessionStateChanged();
  }
}
