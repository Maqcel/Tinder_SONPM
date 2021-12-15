import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

class AppInit {
  static Future<void> initApp() async {
    await _initFirebase();
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  static Future<void> _initFirebase() async => await Firebase.initializeApp();
}
