part of 'conversation_screen_cubit.dart';

abstract class ConversationScreenState extends Equatable {
  const ConversationScreenState();

  @override
  List<Object> get props => [];
}

class ConversationLoading extends ConversationScreenState {}

class ConversationLoaded extends ConversationScreenState {
  final Chat chat;
  final List<MessagePresentation> messages;
  final bool isSendButtonEnabled;

  const ConversationLoaded({
    required this.chat,
    required this.messages,
    required this.isSendButtonEnabled,
  });

  ConversationLoaded copyWith({
    Chat? chat,
    List<MessagePresentation>? messages,
    bool? isSendButtonEnabled,
  }) =>
      ConversationLoaded(
        chat: chat ?? this.chat,
        messages: messages ?? this.messages,
        isSendButtonEnabled: isSendButtonEnabled ?? this.isSendButtonEnabled,
      );

  @override
  List<Object> get props => [
        chat,
        messages,
        isSendButtonEnabled,
      ];
}

class ConversationLoadError extends ConversationScreenState {
  final Failure failure;

  const ConversationLoadError({required this.failure});

  @override
  List<Object> get props => [failure];
}
