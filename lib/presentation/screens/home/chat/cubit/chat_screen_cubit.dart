import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tinder/domain/common/failure.dart';
import 'package:tinder/domain/model/chat/chat.dart';

part 'chat_screen_state.dart';

class ChatScreenCubit extends Cubit<ChatScreenState> {
  // TODO: Implement repository
  // final ChatRepository _chatRepository;
  ChatScreenCubit() : super(ChatLoading());

  Future<void> onScreenOpened() async => await _loadChatList();

  // TODO: Implement repository and function
  Future<void> _loadChatList() async {
    emit(ChatLoading());
    await Future.delayed(const Duration(milliseconds: 300));
    emit(const ChatLoaded(chats: []));
  }
}
