import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as flyer;
import 'package:flutter_chat_ui/flutter_chat_ui.dart' as flyerui;
import 'package:tinder/config/dimensions/animation_dimension.dart';
import 'package:tinder/config/dimensions/padding_dimension.dart';
import 'package:tinder/domain/model/chat/chat.dart';
import 'package:tinder/extensions/build_context_extension.dart';
import 'package:tinder/presentation/common/screen_failure_handler.dart';
import 'package:tinder/presentation/screens/home/chat/conversation/chat_data_provider.dart';
import 'package:tinder/presentation/screens/home/chat/conversation/cubit/conversation_screen_cubit.dart';
import 'package:tinder/presentation/screens/home/chat/conversation/tinder_chat_theme.dart';
import 'package:tinder/presentation/screens/home/chat/conversation/widgets/conversation_empty_placeholder.dart';
import 'package:tinder/presentation/screens/home/chat/conversation/widgets/conversation_message_input.dart';
import 'package:tinder/presentation/screens/home/chat/conversation/widgets/text_message_bubble.dart';
import 'package:tinder/presentation/widget/appbar/cancel_icon_button.dart';

class ConversationScreen extends StatefulWidget {
  final Chat _chatData;

  const ConversationScreen({
    Key? key,
    required Chat chat,
  })  : _chatData = chat,
        super(key: key);

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen>
    with ScreenFailureHandler {
  // Defines how much time needs to pass to display date header on chat
  // 900000ms is equal to 15 minutes
  // The same threshold is used for grouping to make sure messages are
  // grouped the same way as date separators
  final int _chatDateHeaderThresholdMilliseconds = 900000;
  late final FlyerChatDataProvider _chatDataProvider;
  late final TextEditingController _messageInputController =
      TextEditingController();

  // This reference needs to be stored in state because we can't access context.read() inside dispose
  late final Function() _cancelConversationSubscription;

  @override
  void initState() {
    super.initState();
    _chatDataProvider = FlyerChatDataProvider(chat: widget._chatData);
    _messageInputController.addListener(_onInputStateChanged);
    context.read<ConversationScreenCubit>().onScreenOpened(widget._chatData.id);
    _cancelConversationSubscription =
        context.read<ConversationScreenCubit>().clearStreamSubscription;
  }

  void _onInputStateChanged() => context
      .read<ConversationScreenCubit>()
      .onInputTextChanged(_messageInputController.text);

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<ConversationScreenCubit, ConversationScreenState>(
        buildWhen: (previous, current) => _buildWhen(previous, current),
        builder: (context, state) => _body(state),
        listener: (context, state) => _onStateChanged(state),
      );

  bool _buildWhen(
    ConversationScreenState previous,
    ConversationScreenState current,
  ) =>
      (current is ConversationLoading || current is ConversationLoaded);

  Widget _body(ConversationScreenState state) => Scaffold(
        appBar: AppBar(
          toolbarHeight: kToolbarHeight + PaddingDimension.medium,
          leading: const CancelIconButton(),
          title: _appBarImage(),
          centerTitle: true,
          elevation: 1.0,
        ),
        body: AnimatedSwitcher(
          duration: AnimationDimension.durationShort,
          child: _content(context, state),
        ),
      );

  Widget _appBarImage() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            child: CircularProgressIndicator(
                color: context.theme.colorScheme.secondary),
            foregroundImage: NetworkImage(widget._chatData.match.photoUrl),
            backgroundColor: Colors.transparent,
          ),
          Text(
            widget._chatData.match.name,
            style: context.theme.textTheme.headline6,
          ),
        ],
      );

  Widget _content(BuildContext context, ConversationScreenState state) {
    if (state is ConversationLoaded) {
      return flyerui.Chat(
        user: _chatDataProvider.currentUser,
        dateHeaderThreshold: _chatDateHeaderThresholdMilliseconds,
        groupMessagesThreshold: _chatDateHeaderThresholdMilliseconds,
        emojiEnlargementBehavior: flyerui.EmojiEnlargementBehavior.never,
        disableImageGallery: true,
        messages: _chatDataProvider.mapMessages(state.messages),
        customBottomWidget: _chatInput(context, state),
        textMessageBuilder: (
          message, {
          required messageWidth,
          required showName,
        }) =>
            _chatTextMessage(context, state, message, messageWidth),
        onSendPressed: (text) {
          // Do nothing, this action is handled by custom input
        },
        emptyState: ConversationEmptyPlaceholder(
          name: widget._chatData.match.name,
          photoUrl: widget._chatData.match.photoUrl,
        ),
        theme: TinderChatTheme(context),
      );
    } else {
      return _loadingIndicator(context);
    }
  }

  Widget _chatInput(BuildContext context, ConversationLoaded state) =>
      ConversationMessageInput(
        controller: _messageInputController,
        isSendButtonEnabled: state.isSendButtonEnabled,
        onSendButtonClicked: () => _onSendButtonClicked(context),
      );

  void _onSendButtonClicked(BuildContext context) {
    context
        .read<ConversationScreenCubit>()
        .onSendMessageClicked(_messageInputController.text);
    _messageInputController.clear();
  }

  Widget _chatTextMessage(
    BuildContext context,
    ConversationLoaded state,
    flyer.TextMessage message,
    int maxWidth,
  ) =>
      TextMessageBubble(
        fromCurrentUser: message.author.id == state.chat.match.uid,
        maxWidth: maxWidth.toDouble(),
        message: message,
      );

  Widget _loadingIndicator(BuildContext context) => Center(
        child: CircularProgressIndicator(
          color: context.theme.colorScheme.secondary,
        ),
      );

  void _onStateChanged(ConversationScreenState state) {
    if (state is ConversationLoadError) {
      handleFailureInUi(context: context, failure: state.failure);
    }
  }

  @override
  void dispose() {
    _cancelConversationSubscription();
    _messageInputController.dispose();
    super.dispose();
  }
}
