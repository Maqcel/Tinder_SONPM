import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tinder/config/paths.dart';
import 'package:tinder/dto/onboarding/onboarding_completed_request_dto.dart';

class OnboardingRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> completeOnboarding(
          OnboardingCompletedRequestDTO onboardingData) async =>
      await _firestore
          .collection(Paths.usersPath)
          .doc(_firebaseAuth.currentUser!.uid)
          .update(onboardingData.toJson());
}
