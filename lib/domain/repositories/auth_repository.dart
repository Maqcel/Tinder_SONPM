import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  bool hasValidUserSession() =>
      FirebaseAuth.instance.currentUser == null ? false : true;

  String getCurrentUserUid() => FirebaseAuth.instance.currentUser!.uid;

  void clearLocalUserSession() => FirebaseAuth.instance.signOut();
}
