import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:tinder/domain/common/failure.dart';
import 'package:tinder/domain/model/chat/chat.dart';
import 'package:tinder/domain/repositories/auth_repository.dart';
import 'package:tinder/domain/repositories/chat_repository.dart';

part 'chat_screen_state.dart';

class ChatScreenCubit extends Cubit<ChatScreenState> {
  final ChatRepository _chatRepository;
  final AuthRepository _authRepository;
  // ignore: cancel_subscriptions
  StreamSubscription<QuerySnapshot>? _chatListSubscription;

  ChatScreenCubit({
    required ChatRepository chatRepository,
    required AuthRepository authRepository,
  })  : _chatRepository = chatRepository,
        _authRepository = authRepository,
        super(ChatLoading());

  Future<void> onScreenOpened() async => await _startChatsStream();

  Future<void> _startChatsStream() async {
    _chatListSubscription ??= (await _chatRepository.createChatsStream(
            uid: _authRepository.getCurrentUserUid()))
        ?.listen((snapshot) => _onSnapshot(snapshot));

    if (_chatListSubscription == null) {
      emit(const ChatLoaded(chats: []));
    }
  }

  Future<void> _onSnapshot(QuerySnapshot snapshot) async => emit(ChatLoaded(
        chats: await _chatRepository.getChatsFromSnapshot(
          snapshot,
          _authRepository.getCurrentUserUid(),
        ),
      ));

  @override
  Future<void> close() {
    if (_chatListSubscription != null) {
      _chatListSubscription!.cancel();
    }
    return super.close();
  }
}
