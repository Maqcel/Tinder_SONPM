import 'dart:developer';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinder/config/app_init.dart';
import 'package:tinder/config/localization/localization_config.dart';
import 'package:tinder/config/theme/default_theme.dart';
import 'package:tinder/di/app_bloc_providers.dart';
import 'package:tinder/di/app_repository_providers.dart';
import 'package:tinder/di/service_locator.dart';
import 'package:tinder/presentation/app/navigation/user_session_router.dart';

class TinderApp extends StatelessWidget {
  const TinderApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: AppInit.initApp(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            log(
              'App init failed!',
              error: snapshot.error,
              stackTrace: snapshot.stackTrace,
            );
          }
          return _app();
        },
      );

  Widget _app() => MaterialApp(
        debugShowCheckedModeBanner: false,
        supportedLocales: LocalizationConfig.supportedLocalizations,
        localizationsDelegates: LocalizationConfig.localizationDelegate,
        theme: DefaultTheme().themeData,
        navigatorObservers: [
          FirebaseAnalyticsObserver(
            analytics: ServiceLocator.get<FirebaseAnalytics>(),
          ),
        ],
        home: MultiRepositoryProvider(
          providers: AppRepositoryProviders().providers,
          child: MultiBlocProvider(
            providers: AppBlocProviders().providers,
            child: Router(
              routerDelegate: UserSessionRouter(),
              backButtonDispatcher: RootBackButtonDispatcher(),
            ),
          ),
        ),
      );
}
