part of 'chat_screen_cubit.dart';

abstract class ChatScreenState extends Equatable {
  const ChatScreenState();

  @override
  List<Object> get props => [];
}

class ChatLoading extends ChatScreenState {}

class ChatLoaded extends ChatScreenState {
  final List<Chat> chats;

  const ChatLoaded({required this.chats});

  @override
  List<Object> get props => [chats];
}

class ChatLoadError extends ChatScreenState {
  final Failure failure;

  const ChatLoadError({required this.failure});

  @override
  List<Object> get props => [failure];
}

class ChatRefreshError extends ChatScreenState {
  final Failure failure;

  const ChatRefreshError({required this.failure});

  @override
  List<Object> get props => [failure];
}
