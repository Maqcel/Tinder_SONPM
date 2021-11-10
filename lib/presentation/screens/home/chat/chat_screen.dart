import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinder/config/dimensions/animation_dimension.dart';
import 'package:tinder/config/theme/color_palette.dart';
import 'package:tinder/domain/model/chat/chat.dart';
import 'package:tinder/extensions/build_context_extension.dart';
import 'package:tinder/gen/assets.gen.dart';
import 'package:tinder/presentation/common/screen_failure_handler.dart';
import 'package:tinder/presentation/screens/home/chat/chat_list_builder.dart';
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

  Widget _body(ChatScreenState state) => Scaffold(
        appBar: AppBar(
          leading: Assets.images.icons.tinderWhite
              .svg(color: ColorPalette.colorPrimary100),
        ),
        body: AnimatedSwitcher(
          duration: AnimationDimension.durationShort,
          child: _content(context, state),
        ),
      );

  Widget _content(BuildContext context, ChatScreenState state) {
    if (state is ChatLoaded) {
      return _chatList(context, state.chats);
    } else {
      return _loadingIndicator(context);
    }
  }

  Widget _chatList(
    BuildContext context,
    List<Chat> chats,
  ) =>
      ChatListBuilder.build(
        context: context,
        chats: chats,
        onChatClicked: (chat) => _onChatClicked(chat),
      );

  Widget _loadingIndicator(BuildContext context) => Center(
        child: CircularProgressIndicator(
          color: context.theme.colorScheme.secondary,
        ),
      );

  void _onChatClicked(Chat chat) =>
      context.read<MainNavigationCubit>().chatListToConversation(chat);

  void _onStateChanged(ChatScreenState state) {
    if (state is ChatLoadError) {
      handleFailureInUi(context: context, failure: state.failure);
    }
  }
}
