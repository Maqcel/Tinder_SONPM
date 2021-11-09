part of 'chat_screen_cubit.dart';

abstract class ChatScreenState extends Equatable {
  const ChatScreenState();

  @override
  List<Object> get props => [];
}

class ChatScreenLoading extends ChatScreenState {}

class ChatScreenLoaded extends ChatScreenState {}

class ChatScreenLoadError extends ChatScreenState {
  final Failure failure;

  const ChatScreenLoadError({required this.failure});

  @override
  List<Object> get props => [failure];
}
