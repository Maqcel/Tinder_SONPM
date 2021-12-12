import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinder/domain/repositories/auth_repository.dart';
import 'package:tinder/domain/repositories/onboarding_repository.dart';
import 'package:tinder/presentation/app/navigation/cubit/user_session_navigation_cubit.dart';
import 'package:tinder/presentation/screens/auth/navigation/cubit/auth_navigation_cubit.dart';
import 'package:tinder/presentation/screens/home/navigation/cubit/home_navigation_cubit.dart';
import 'package:tinder/presentation/screens/main/navigation/cubit/main_navigation_cubit.dart';
import 'package:tinder/presentation/screens/onboarding/cubit/onboarding_screen_cubit.dart';

class AppBlocProviders {
  List<BlocProvider> get providers => [
        BlocProvider<UserSessionNavigationCubit>(
          lazy: false,
          create: (context) => UserSessionNavigationCubit(
            authRepository: context.read<AuthRepository>(),
          ),
        ),
        BlocProvider<OnboardingScreenCubit>(
          lazy: true,
          create: (context) => OnboardingScreenCubit(
            onboardingRepository: context.read<OnboardingRepository>(),
          ),
        ),
        BlocProvider<AuthNavigationCubit>(
          lazy: true,
          create: (context) => AuthNavigationCubit(),
        ),
        BlocProvider<MainNavigationCubit>(
          lazy: true,
          create: (context) => MainNavigationCubit(),
        ),
        BlocProvider<HomeNavigationCubit>(
          lazy: true,
          create: (context) => HomeNavigationCubit(),
        ),
      ];
}
