import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tinder/config/paths.dart';
import 'package:tinder/domain/model/chat/chat.dart';
import 'package:tinder/dto/chat/chat_response_dto.dart';
import 'package:tinder/dto/user/user_chats_response_dto.dart';

class ChatRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot>? _chatsListStream;

  Future<Stream<QuerySnapshot>> createChatsStream({required String uid}) async {
    if (_chatsListStream != null) {
      return _chatsListStream!;
    }

    List<String> chatsId = UserChatsResponseDTO.fromJson(
            (await _firestore.collection(Paths.usersPath).doc(uid).get())
                .data()!)
        .matches;

    return _chatsListStream = _firestore
        .collection(Paths.chatsPath)
        .where(FieldPath.documentId, whereIn: chatsId)
        .snapshots();
  }

  Future<List<Chat>> getChatsFromSnapshot(
          QuerySnapshot snapshot, String uid) async =>
      snapshot.docs
          .map((doc) => Chat.fromDto(
                ChatResponseDTO.fromFirestore(
                  doc.id,
                  doc.data() as Map<String, dynamic>,
                ),
                uid,
              ))
          .toList();
}
