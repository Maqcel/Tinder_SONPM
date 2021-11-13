import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:tinder/domain/common/failure.dart';
import 'package:tinder/domain/model/chat/chat.dart';
import 'package:tinder/domain/model/chat/conversation.dart';
import 'package:tinder/domain/model/chat/message.dart';
import 'package:tinder/domain/repositories/auth_repository.dart';
import 'package:tinder/domain/repositories/chat_repository.dart';
import 'package:tinder/presentation/screens/home/chat/conversation/message_presentation.dart';

part 'conversation_screen_state.dart';

class ConversationScreenCubit extends Cubit<ConversationScreenState> {
  final ChatRepository _chatRepository;
  final AuthRepository _authRepository;
  // ignore: cancel_subscriptions
  StreamSubscription<QuerySnapshot>? _conversationSubscription;

  ConversationScreenCubit({
    required ChatRepository chatRepository,
    required AuthRepository authRepository,
  })  : _chatRepository = chatRepository,
        _authRepository = authRepository,
        super(ConversationLoading());

  Future<void> onScreenOpened(String chatId) async =>
      await _startConversationStream(chatId);

  Future<void> _startConversationStream(String chatId) async {
    await clearStreamSubscription();
    _conversationSubscription =
        (await _chatRepository.createConversationStream(chatId: chatId))
            .listen((snapshot) => _onSnapshot(snapshot));
  }

  Future<void> _onSnapshot(QuerySnapshot snapshot) async {
    Conversation conversation =
        await _chatRepository.getConversationFromSnapshot(
      snapshot: snapshot,
      uid: _authRepository.getCurrentUserUid(),
    );

    List<MessagePresentation> messages = conversation.messages
        .map((message) => MessagePresentation.fromExistingMessage(
              message,
              isUsersMessage:
                  message.sentBy == _authRepository.getCurrentUserUid(),
            ))
        .toList();

    if (state is ConversationLoaded) {
      emit((state as ConversationLoaded).copyWith(
        chat: conversation.chatData,
        messages: messages,
      ));
    } else {
      emit(ConversationLoaded(
        chat: conversation.chatData,
        messages: messages,
        isSendButtonEnabled: false,
      ));
    }
  }

  Future<void> onInputTextChanged(String text) async {
    ConversationLoaded currentState = state as ConversationLoaded;
    emit(currentState.copyWith(isSendButtonEnabled: text.isNotEmpty));
  }

  Future<void> onSendMessageClicked(String text) async {
    MessagePresentation localMessage =
        MessagePresentation.newLocalMessage(text);

    // Retrieve list of current messages and add created message to it
    // Then update the state to show message on chat before actually sending it
    List<MessagePresentation> currentMessageList =
        List.of((state as ConversationLoaded).messages);
    currentMessageList.add(localMessage);
    emit((state as ConversationLoaded).copyWith(messages: currentMessageList));

    // Send local message to firebase and handle the result
    (await _chatRepository.sendChatMessage(
            (state as ConversationLoaded).chat, text))
        .fold((error) => _onMessageSendError(localMessage, error),
            (data) => _onMessageSendSuccess(localMessage, data));
  }

  Future<void> _onMessageSendSuccess(
    MessagePresentation localMessage,
    Message remoteMessage,
  ) async {
    // Retrieve list of current messages and find index of local message
    List<MessagePresentation> messages =
        List.of((state as ConversationLoaded).messages);
    MessagePresentation remoteMessagePresentation =
        MessagePresentation.fromExistingMessage(remoteMessage,
            isUsersMessage: true);
    int localMessageIndex = messages
        .indexWhere((message) => message.localId == localMessage.localId);

    // If message exists, replace it with remote copy updating it's local ID
    // To match the one already displayed. If it does not, wait for push to
    // Create the message (may happen if push occurs before this finishes)
    if (localMessageIndex != -1) {
      messages[localMessageIndex] = remoteMessagePresentation.copyWith(
        localId: localMessage.localId,
      );
    }

    emit((state as ConversationLoaded).copyWith(messages: messages));
  }

  Future<void> _onMessageSendError(
      MessagePresentation localMessage, Failure failure) async {
    List<MessagePresentation> messages =
        List.of((state as ConversationLoaded).messages);
    int localMessageIndex = messages
        .indexWhere((message) => message.localId == localMessage.localId);

    if (localMessageIndex != -1) {
      messages[localMessageIndex] =
          localMessage.copyWith(status: MessageStatus.error);
    } else {
      log('Local message was not found in chat!');
      messages.add(localMessage.copyWith(status: MessageStatus.error));
    }

    emit((state as ConversationLoaded).copyWith(messages: messages));
  }

  Future<void> clearStreamSubscription() async {
    if (_conversationSubscription != null) {
      await _conversationSubscription!.cancel();
      _conversationSubscription = null;
    }
  }
}
