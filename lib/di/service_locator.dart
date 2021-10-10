import 'dart:developer';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get_it/get_it.dart';

class ServiceLocator {
  static final GetIt _getIt = GetIt.instance;

  static void init() {
    _initAnalytics();
    log("Services Initialized");
  }

  static void _initAnalytics() =>
      _getIt.registerSingleton<FirebaseAnalytics>(FirebaseAnalytics());

  static T get<T extends Object>() => _getIt.get<T>();
}
