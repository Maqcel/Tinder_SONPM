import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinder/presentation/common/screen_failure_handler.dart';
import 'package:tinder/presentation/screens/home/chat/cubit/chat_screen_cubit.dart';
import 'package:tinder/presentation/screens/main/navigation/cubit/main_navigation_cubit.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with ScreenFailureHandler {
  @override
  void initState() {
    super.initState();
    context
        .read<ChatScreenCubit>()
        .onScreenOpened('hUTjuJwylLWR04yDtpOPnC9JhY53');
  }

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<ChatScreenCubit, ChatScreenState>(
        buildWhen: (previous, current) => _buildWhen(previous, current),
        builder: (context, state) => _body(state),
        listener: (context, state) => _onStateChanged(state),
      );

  bool _buildWhen(
    ChatScreenState previous,
    ChatScreenState current,
  ) =>
      (current is ChatLoading || current is ChatLoaded);

  // TODO: Implement content
  Widget _body(ChatScreenState state) => GestureDetector(
        onTap: () => _onChatTileClicked(),
        child: Scaffold(
          backgroundColor: state is ChatLoading ? Colors.amber : Colors.green,
          body: Center(
            child: Text(
              state is ChatLoading
                  ? ''
                  : (state as ChatLoaded).chats.length.toString(),
              style: const TextStyle(fontSize: 50),
            ),
          ),
        ),
      );

  void _onChatTileClicked() =>
      context.read<MainNavigationCubit>().chatListToConversation();

  void _onStateChanged(ChatScreenState state) {
    if (state is ChatLoadError) {
      handleFailureInUi(context: context, failure: state.failure);
    }
  }
}
