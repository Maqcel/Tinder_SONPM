import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tinder/config/paths.dart';
import 'package:tinder/domain/model/possible_match/possible_match.dart';
import 'package:tinder/domain/model/user/user_profile.dart';
import 'package:tinder/dto/possible_matches/possible_matches_resposnse_dto.dart';
import 'package:tinder/dto/user/user_profile_response_dto.dart';

class PeopleRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<PossibleMatch>> fetchUsers({String? fetchAfterUid}) async {
    final QuerySnapshot<Map<String, dynamic>> result;
    if (fetchAfterUid == null) {
      result = await _firestore
          .collection(Paths.usersPath)
          .orderBy('uid')
          .limit(4)
          .get();
    } else {
      DocumentSnapshot fetchAfter =
          await _firestore.collection(Paths.usersPath).doc(fetchAfterUid).get();
      result = await _firestore
          .collection(Paths.usersPath)
          .orderBy('uid')
          .startAfterDocument(fetchAfter)
          .limit(4)
          .get();
    }
    return result.docs
        .map((document) => PossibleMatch.fromDto(
              PossibleMatchesResponseDTO.fromJson(document.data()),
            ))
        .toList();
  }

  Future<void> createMatch(String possibleMatchUid) async {
    final List<QueryDocumentSnapshot<Map<String, dynamic>>> userUid =
        (await _firestore.collection(Paths.possibleMatchesPath).get()).docs;
    final bool? hasMatch = userUid
        .firstWhereOrNull((element) =>
            (element.data()['user1'] == possibleMatchUid &&
                element.data()['user2'] == _firebaseAuth.currentUser!.uid) ||
            (element.data()['user2'] == possibleMatchUid &&
                element.data()['user1'] == _firebaseAuth.currentUser!.uid))
        ?.exists;
    if (hasMatch == null) {
      await _firestore.collection(Paths.possibleMatchesPath).add({
        'user1': possibleMatchUid,
        'user2': _firebaseAuth.currentUser!.uid,
      });
    } else {
      UserProfile user = await _getUserProfile(_firebaseAuth.currentUser!.uid);
      UserProfile match = await _getUserProfile(possibleMatchUid);
      DocumentReference chat =
          await _firestore.collection(Paths.chatsPath).add({
        'pair': [
          {
            'name': user.name,
            'photoUrl': user.photoUrl,
            'uid': user.uid,
          },
          {
            'name': match.name,
            'photoUrl': match.photoUrl,
            'uid': match.uid,
          },
        ]
      });
      await _firestore
          .collection(Paths.usersPath)
          .doc(_firebaseAuth.currentUser!.uid)
          .update({
        'matches': FieldValue.arrayUnion([chat.id])
      });
    }
  }

  Future<UserProfile> _getUserProfile(String uid) async {
    DocumentSnapshot data =
        await _firestore.collection(Paths.usersPath).doc(uid).get();
    return UserProfile.fromDto(
        UserProfileDTO.fromJson(data.data() as Map<String, dynamic>));
  }
}
