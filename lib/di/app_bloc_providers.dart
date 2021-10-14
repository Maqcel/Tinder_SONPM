import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinder/domain/repositories/auth_repository.dart';
import 'package:tinder/presentation/app/navigation/cubit/user_session_navigation_cubit.dart';
import 'package:tinder/presentation/screens/auth/navigation/cubit/auth_navigation_cubit.dart';

class AppBlocProviders {
  List<BlocProvider> get providers => [
        BlocProvider<UserSessionNavigationCubit>(
          lazy: false,
          create: (context) => UserSessionNavigationCubit(
            authRepository: context.read<AuthRepository>(),
          ),
        ),
        BlocProvider<AuthNavigationCubit>(
          lazy: true,
          create: (context) => AuthNavigationCubit(),
        ),
      ];
}
