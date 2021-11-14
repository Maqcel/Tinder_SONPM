import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tinder/config/paths.dart';
import 'package:tinder/domain/common/failure.dart';
import 'package:tinder/domain/model/chat/chat.dart';
import 'package:tinder/domain/model/chat/conversation.dart';
import 'package:tinder/domain/model/chat/message.dart';
import 'package:tinder/dto/chat/chat_response_dto.dart';
import 'package:tinder/dto/chat/conversation_response_dto.dart';
import 'package:tinder/dto/chat/message_request_dto.dart';
import 'package:tinder/dto/user/user_chats_response_dto.dart';

class ChatRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Stream<QuerySnapshot>> createChatsStream({required String uid}) async {
    List<String> chatsId = UserChatsResponseDTO.fromJson(
            (await _firestore.collection(Paths.usersPath).doc(uid).get())
                .data()!)
        .matches;

    return _firestore
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

  Future<Stream<QuerySnapshot>> createConversationStream(
          {required String chatId}) async =>
      _firestore
          .collection(Paths.chatsPath)
          .where(FieldPath.documentId, isEqualTo: chatId)
          .limit(1)
          .snapshots();

  Future<Conversation> getConversationFromSnapshot({
    required QuerySnapshot snapshot,
    required String uid,
  }) async {
    Map<String, dynamic> bulkJson = {};
    bulkJson.addAll(snapshot.docs.first.data() as Map<String, dynamic>);

    // Check if message collection exist then fetch messages
    if (bulkJson.containsKey('mostRecentMessage')) {
      bulkJson.addAll({
        'messages': (await snapshot.docs.first.reference
                .collection(Paths.messagesPath)
                .orderBy('sentAt', descending: false)
                .snapshots()
                .first)
            .docs,
      });
    }

    return Conversation.fromDto(
        ConversationResponseDTO.fromFirestore(snapshot.docs.first.id, bulkJson),
        uid);
  }

  Future<Either<Failure, Message>> sendChatMessage(
      Chat chatData, String messageText) async {
    DocumentReference chatReference =
        _firestore.collection(Paths.chatsPath).doc(chatData.id);

    chatReference
        .collection(Paths.messagesPath)
        .add(
          MessageRequestDTO(
                  messageText: messageText,
                  sentBy: chatData.user.uid,
                  sentAt: DateTime.now())
              .toJson(),
        )
        .then((value) => chatReference.update({
              'mostRecentMessage': MessageRequestDTO(
                      messageText: messageText,
                      sentBy: chatData.user.uid,
                      sentAt: DateTime.now())
                  .toJson()
            }))
        .onError((error, stackTrace) => left(const UnexpectedFailure()));

    return right(Message(
      id: null,
      messageText: messageText,
      sentAt: DateTime.now(),
      sentBy: chatData.user.uid,
    ));
  }
}
