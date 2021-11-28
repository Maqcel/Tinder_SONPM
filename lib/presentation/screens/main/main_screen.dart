import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinder/domain/repositories/auth_repository.dart';
import 'package:tinder/domain/repositories/chat_repository.dart';
import 'package:tinder/domain/repositories/user_repository.dart';
import 'package:tinder/extensions/build_context_extension.dart';
import 'package:tinder/presentation/screens/home/chat/cubit/chat_screen_cubit.dart';
import 'package:tinder/presentation/screens/home/possible_match/cubit/possible_match_cubit.dart';
import 'package:tinder/presentation/screens/home/profile/cubit/profile_screen_cubit.dart';
import 'package:tinder/presentation/screens/main/navigation/main_router.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final MainRouter _routerDelegate = MainRouter();
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
          BlocProvider<ChatScreenCubit>(
            create: (context) => ChatScreenCubit(
              chatRepository: context.read<ChatRepository>(),
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<ProfileScreenCubit>(
            create: (context) => ProfileScreenCubit(
              userRepository: context.read<UserRepository>(),
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<PossibleMatchScreenCubit>(
            create: (context) => PossibleMatchScreenCubit(
              userRepository: context.read<UserRepository>(),
              authRepository: context.read<AuthRepository>(),
            ),
          )
        ],
        child: Router(
          routerDelegate: _routerDelegate,
          backButtonDispatcher: _backButtonDispatcher,
        ),
      );
// MultiBlocProvider(
//       providers: const [
  /// For Each screen you should add cubit to manage it state internally
  /// But at first you need to initialize it here
  /// The case is to initialize cubit of the child in the parent navigator
  /// So in this navigator only for:
  /// - Profile
  /// - Chat
  /// - People
  /// - Possible Match
  /// Ofc if they will require cubit but those 4 will :)
  ///
  /// BlocProvider<ProfileScreenCubit>(
  /// this ensure that cubit will stay in memory even after switching the screen
  ///   lazy: true,
  ///   create: (context) => ProfileScreenCubit(),
  /// ),
//       ],
//       child: Router(
//         routerDelegate: _routerDelegate,
//         backButtonDispatcher: _backButtonDispatcher,
//       ),
//     );
}
