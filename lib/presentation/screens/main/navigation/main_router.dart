import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinder/domain/repositories/auth_repository.dart';
import 'package:tinder/domain/repositories/chat_repository.dart';
import 'package:tinder/presentation/common/navigation/cubit_router.dart';
import 'package:tinder/presentation/page_transitions/slide_transition_page.dart';
import 'package:tinder/presentation/screens/home/chat/conversation/conversation_screen.dart';
import 'package:tinder/presentation/screens/home/chat/conversation/cubit/conversation_screen_cubit.dart';
import 'package:tinder/presentation/screens/home/home_screen.dart';
import 'package:tinder/presentation/screens/home/possible_match/possible_match_details.dart';
import 'package:tinder/presentation/screens/home/profile/pofile_details_ui.dart';
import 'package:tinder/presentation/screens/home/profile/prifile_settings_ui.dart';
import 'package:tinder/presentation/screens/main/navigation/cubit/main_navigation_cubit.dart';
import 'package:tinder/routing/app_routes.dart';

/// This router handles navigation between [HomeScreen]
/// And all the pages displayed 'above' it as full screen popups
/// Eg. Setting from profile screen will be added here, also chat, other people
/// profiles and most of the nested actions
/// more complex routing can be managed with nested routers but thats more complex topic
/// not needed for now
class MainRouter
    extends CubitRouter<MainNavigationCubit, MainNavigationState, void> {
  static final GlobalKey<NavigatorState> key =
      GlobalKey(debugLabel: 'MainRouterKey');

  @override
  GlobalKey<NavigatorState> internalNavigationKey = key;

  @override
  List<Page> getPageStack(BuildContext context, MainNavigationState state) {
    List<Page> pageStack = [];

    pageStack.add(SlideTransitionPage.fromRoute(
      route: AppRoutes.home,
      child: const HomeScreen(),
    ));

    if (state is MainNavigationChatConversation) {
      pageStack.add(SlideTransitionPage.fromRoute(
        route: AppRoutes.chatListConversation,
        child: BlocProvider<ConversationScreenCubit>(
          create: (context) => ConversationScreenCubit(
            chatRepository: context.read<ChatRepository>(),
            authRepository: context.read<AuthRepository>(),
          ),
          child: ConversationScreen(chat: state.chat),
        ),
      ));
    }

    if (state is MainNavigationSettings) {
      pageStack.add(SlideTransitionPage.fromRoute(
          route: AppRoutes.profileSettings, child: const ProfileSettings()));
    }

    if (state is MainNavigationDetails) {
      pageStack.add(SlideTransitionPage.fromRoute(
          route: AppRoutes.profileSettings,
          child: ProfileDetails(profile: state.profile)));
    }

    if (state is MainNavigationMatchDetails) {
      pageStack.add(SlideTransitionPage.fromRoute(
          route: AppRoutes.homePossibleMatch,
          child: PossibleMatchDetails(profile: state.profile)));
    }

    return pageStack;
  }
}
