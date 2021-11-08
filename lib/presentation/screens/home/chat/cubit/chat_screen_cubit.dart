import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tinder/domain/common/failure.dart';

part 'chat_screen_state.dart';

class ChatScreenCubit extends Cubit<ChatScreenState> {
  // final ChatRepository _chatRepository;
  ChatScreenCubit() : super(ChatScreenLoading());

  Future<void> onScreenOpened() async => await _loadChatList();

  // TODO: Implement repository and function
  Future<void> _loadChatList() async {
    emit(ChatScreenLoading());
    await Future.delayed(const Duration(milliseconds: 300));
    emit(ChatScreenLoaded());
  }
}
