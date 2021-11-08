import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinder/extensions/build_context_extension.dart';
import 'package:tinder/presentation/common/screen_failure_handler.dart';
import 'package:tinder/presentation/screens/home/chat/cubit/chat_screen_cubit.dart';
import 'package:tinder/presentation/screens/main/navigation/cubit/main_navigation_cubit.dart';
import 'package:tinder/routing/app_routes.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with ScreenFailureHandler {
  @override
  void initState() {
    super.initState();
    context.read<ChatScreenCubit>().onScreenOpened();
  }

  @override
  Widget build(BuildContext context) =>
      BlocListener<MainNavigationCubit, MainNavigationState>(
        listener: (context, state) => _onMainNavigationStateChanged(state),
        child: BlocConsumer<ChatScreenCubit, ChatScreenState>(
          buildWhen: (previous, current) => _buildWhen(previous, current),
          builder: (context, state) => _body(state),
          listener: (context, state) => _onStateChanged(state),
        ),
      );

  // Control when u will came back from conversation
  void _onMainNavigationStateChanged(MainNavigationState state) {
    if (state is MainNavigationHome) {
      if (state.previousRoute == AppRoutes.chatListConversation) {
        context.read<ChatScreenCubit>().onScreenOpened();
      }
    }
  }

  // Control on which state widget should rebuild
  bool _buildWhen(
    ChatScreenState previous,
    ChatScreenState current,
  ) =>
      (current is ChatScreenLoading || current is ChatScreenLoaded);

  // TODO: Implement content
  // Control what should be build
  Widget _body(ChatScreenState state) => Scaffold(
        backgroundColor: Colors.red,
        body: Center(
          child: GestureDetector(
            onTap: () => _onChatTileClicked(),
            child: Text(context.localizations.chatText),
          ),
        ),
      );

  void _onChatTileClicked() =>
      context.read<MainNavigationCubit>().chatListToConversation();

  // Control if some action should happen on the screen on some state
  // eg. show dialog with error
  void _onStateChanged(ChatScreenState state) {
    if (state is ChatScreenLoadError) {
      handleFailureInUi(context: context, failure: state.failure);
    }
  }
}
