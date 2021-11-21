import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinder/domain/common/failure.dart';
import 'package:tinder/extensions/build_context_extension.dart';
import 'package:tinder/gen/assets.gen.dart';
import 'package:tinder/presentation/app/navigation/cubit/user_session_navigation_cubit.dart';
import 'package:tinder/presentation/common/screen_failure_handler.dart';
import 'package:tinder/presentation/screens/home/people/swiping_direction.dart';
import 'package:tinder/presentation/screens/home/people/widgets/people_card_widget.dart';

class PeopleScreen extends StatefulWidget {
  const PeopleScreen({Key? key}) : super(key: key);

  @override
  _PeopleScreenState createState() => _PeopleScreenState();
}

class _PeopleScreenState extends State<PeopleScreen> with ScreenFailureHandler {
  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => handleFailureInUi(
          context: context,
          failure: Failure.unexpected(),
          onFailureAcknowledged: () => _testLogOut(context),
        ),
        child: Scaffold(
          appBar: AppBar(
            leading:
                Assets.images.icons.tinderWhite.svg(color: Colors.pink[600]),
          ),
           body: const PeopleCardWidget(swipingDirection: SwipingDirection.right,),
          backgroundColor: Colors.blue,
        ),
      );

  // FIXME: Remove this just temporary demo
  Future<void> _testLogOut(BuildContext context) async {
    // await FirebaseAuth.instance.signOut();
    // context.read<UserSessionNavigationCubit>().onUserSessionStateChanged();
  }
}
