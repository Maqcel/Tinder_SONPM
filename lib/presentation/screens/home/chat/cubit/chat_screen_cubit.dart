import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:tinder/domain/common/failure.dart';
import 'package:tinder/domain/model/chat/chat.dart';
import 'package:tinder/domain/repositories/chat_repository.dart';

part 'chat_screen_state.dart';

class ChatScreenCubit extends Cubit<ChatScreenState> {
  final ChatRepository _chatRepository;
  late final StreamSubscription<QuerySnapshot> _chatListSubscription;

  ChatScreenCubit({required ChatRepository chatRepository})
      : _chatRepository = chatRepository,
        super(ChatLoading());

  Future<void> onScreenOpened(String uid) async => await _startChatsStream(uid);

  Future<void> _startChatsStream(String uid) async => _chatListSubscription =
      (await _chatRepository.createChatsStream(uid: uid))
          .listen((snapshot) => _onSnapshot(snapshot));

  // FIXME: Remove hardcoded uid
  void _onSnapshot(QuerySnapshot snapshot) => emit(ChatLoaded(
        chats: _chatRepository.getChatsFromSnapshot(
            snapshot, 'hUTjuJwylLWR04yDtpOPnC9JhY53'),
      ));

  @override
  Future<void> close() {
    _chatListSubscription.cancel();
    return super.close();
  }
}
