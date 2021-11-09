import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tinder/domain/common/failure.dart';
import 'package:tinder/domain/common/generic_call.dart';
import 'package:tinder/domain/failures/authorization_failure.dart';

class UserRepository {
  Future<Either<Failure, UserCredential>> login({
    required String email,
    required String password,
  }) async =>
      genericCall<UserCredential>(
        functionWithReturn: () =>
            FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        ),
        failure: const AuthorizationFailure(
            message: 'Login unsuccessful, try again!'),
      );

  Future<Either<Failure, UserCredential>> signup({
    required String email,
    required String password,
  }) async =>
      genericCall<UserCredential>(
        functionWithReturn: () => _signUpAndCreateUser(
          email: email,
          password: password,
        ),
        failure: const AuthorizationFailure(
            message: 'Signup unsuccessful, try again!'),
      );

  Future<UserCredential> _signUpAndCreateUser({
    required String email,
    required String password,
  }) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    User user = userCredential.user!;

    DocumentReference userReference =
        FirebaseFirestore.instance.collection('users').doc(user.uid);

    await userReference.set({
      'uid': user.uid,
      'name': null,
      'phone_number': null,
      'gender': null,
      'bio': null,
      'birth_date': null,
      'profile_photo_path': null,
      'location': {
        'lat': null,
        'lon': null,
      },
      'passions': [],
      'matches': [],
    });

    return userCredential;
  }

  Future<void> logout() async => await FirebaseAuth.instance.signOut();
}
