import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tinder/config/paths.dart';
import 'package:tinder/domain/common/failure.dart';
import 'package:tinder/domain/common/generic_call.dart';
import 'package:tinder/domain/failures/authorization_failure.dart';
import 'package:tinder/domain/model/possible_match/possible_match.dart';
import 'package:tinder/domain/model/user/user_profile.dart';
import 'package:tinder/dto/possible_matches/possible_matches_resposnse_dto.dart';
import 'package:tinder/dto/user/user_profile_response_dto.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Either<Failure, UserCredential>> login({
    required String email,
    required String password,
  }) async =>
      genericCall<UserCredential>(
        functionWithReturn: () => _firebaseAuth.signInWithEmailAndPassword(
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
    UserCredential userCredential = await _firebaseAuth
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

  Future<UserProfile> getUserProfile(String uid) async {
    DocumentSnapshot data =
        await _firestore.collection(Paths.usersPath).doc(uid).get();
    return UserProfile.fromDto(
        UserProfileDTO.fromJson(data.data() as Map<String, dynamic>));
  }

  Future<PossibleMatch> getPossibleMatch(String uid) async {
    DocumentSnapshot data =
        await _firestore.collection(Paths.usersPath).doc(uid).get();
    return PossibleMatch.fromDto(PossibleMatchesResponseDTO.fromJson(
        data.data() as Map<String, dynamic>));
  }

  Future<List<PossibleMatch>> getPossibleMatches(String uid) async {
    final List<QueryDocumentSnapshot<Map<String, dynamic>>> userUid =
        (await _firestore
                .collection(Paths.possibleMatchesPath)
                .snapshots()
                .first)
            .docs;

    List<String> possibleMatchesUid = userUid
        .map((document) => ((document.data()['user1'] != uid &&
                document.data()['user2'] != uid)
            ? ""
            : document.data()['user1'] != uid
                ? document.data()['user1']
                : document.data()['user2']) as String)
        .toList();
    List<String> filteredPossibleMatchesUid =
        possibleMatchesUid.where((match) => match != "").toList();



    final List<QueryDocumentSnapshot<Map<String, dynamic>>> usersData =
        (await _firestore
                .collection(Paths.usersPath)
                .where(FieldPath.documentId,
                    whereIn: filteredPossibleMatchesUid)
                .snapshots()
                .first)
            .docs;

    return usersData
        .map((document) => PossibleMatch.fromDto(
            PossibleMatchesResponseDTO.fromJson(document.data())))
        .toList();
  }

  Future<List<PossibleMatch>> getTopPicks(String uid) async {
    final List<QueryDocumentSnapshot<Map<String, dynamic>>> userUid =
        (await _firestore
            .collection(Paths.possibleMatchesPath)
            .snapshots()
            .first)
            .docs;

    List<String> possibleMatchesUid = userUid
        .map((document) => ((document.data()['user1'] != uid &&
        document.data()['user2'] != uid)
        ? ""
        : document.data()['user1'] != uid
        ? document.data()['user1']
        : document.data()['user2']) as String)
        .toList();
    List<String> filteredPossibleMatchesUid =
    possibleMatchesUid.where((match) => match != "").toList();

    filteredPossibleMatchesUid.add(uid);

    final List<QueryDocumentSnapshot<Map<String, dynamic>>> usersData =
        (await _firestore
            .collection("users")
            .where(FieldPath.documentId,
            whereNotIn: filteredPossibleMatchesUid)
            .snapshots()
            .first)
            .docs;

    return usersData
        .map((document) => PossibleMatch.fromDto(
        PossibleMatchesResponseDTO.fromJson(document.data())))
        .toList();
  }

  Future<void> logout() async => await _firebaseAuth.signOut();
}
