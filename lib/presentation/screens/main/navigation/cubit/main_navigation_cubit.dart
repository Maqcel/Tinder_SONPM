import 'package:equatable/equatable.dart';
import 'package:tinder/domain/model/chat/chat.dart';
import 'package:tinder/domain/model/possible_match/possible_match.dart';
import 'package:tinder/domain/model/user/user_profile.dart';
import 'package:tinder/presentation/common/navigation/navigation_cubit.dart';
import 'package:tinder/routing/app_routes.dart';
import 'package:tinder/routing/route_definition.dart';

part 'main_navigation_state.dart';

class MainNavigationCubit extends NavigationCubit<MainNavigationState> {
  MainNavigationCubit()
      : super(initialState: MainNavigationHome(previousRoute: AppRoutes.home));

  /// This is the way to push to single nested screen don't forget to add
  /// Corresponding pop method
  /// 1. Add state to MainNavigationState
  /// 2. Add route definition to AppRoutes
  /// 3. Create 'push' method (Emit created state with all required arguments etc.)
  /// 4. Create pop method
  /// 5. Go to [MainRouter] and add screen on the stack
  ///
  /// Down bellow in the comments I've included code samples

  @override
  void onRoutePop(String? routeName) {
    super.onRoutePop(routeName);
    if (routeName == AppRoutes.chatListConversation.name) {
      _onChatConversationPop();
    } else if (routeName == AppRoutes.profileSettings.name) {
      _onSettingsPop();
    }
    // if (routeName == AppRoutes.someRoute.name) {
    //   _onSomePop();
    // } else if (routeName == AppRoutes.otherRoute.name) {
    //   _onOtherPop();
    // } else if (routeName == AppRoutes.homeProfile.name) {
    //   _onSettingsPop();
    // } else {
    //   onUnknownRouteName(routeName);
    // }
  }

  void _onChatConversationPop() => emit(MainNavigationHome(
        previousRoute: AppRoutes.chatListConversation,
      ));

  void chatListToConversation(Chat chat) => emit(MainNavigationChatConversation(
        chat: chat,
        previousRoute: AppRoutes.chatList,
      ));

  void _onSettingsPop() => emit(MainNavigationHome(
        previousRoute: AppRoutes.profileSettings,
      ));

  void profileToSettings() => emit(MainNavigationSettings(
        previousRoute: AppRoutes.homeProfile,
      ));

  void profileToDetails(UserProfile userProfile) => emit(MainNavigationDetails(
        profile: userProfile,
        previousRoute: AppRoutes.homeProfile,
      ));

  void matchProfileDetails(PossibleMatch userProfile) => emit(MainNavigationMatchDetails(
    profile: userProfile,
    previousRoute: AppRoutes.homePossibleMatch,
  ));

  void goBackToPossibleMatches() => emit(MainNavigationPossibleMatchDetails(
    previousRoute: AppRoutes.homePossibleMatch,
  ));

  // void _onSomePop() => emit(MainNavigationHome(
  //       previousRoute: AppRoutes.someRoute,
  //     ));

  // void _onOtherPop() => emit(MainNavigationHome(
  //       previousRoute: AppRoutes.otherPop,
  //     ));

  // void _onSettingsPop() => emit(MainNavigationHome(
  //       previousRoute: AppRoutes.otherPop,
  //     ));

  // void homeToSome() => emit(MainNavigationSomeRoute(
  //       previousRoute: AppRoutes.homeSomeRoute,
  //     ));

  // void homeToOther() => emit(MainNavigationOtherRoute(
  //       previousRoute: AppRoutes.homeOtherRoute,
  //     ));

  // void profileToSettings() => emit(MainNavigationHomeSetting(
  //       previousRoute: AppRoutes.homeProfile,
  //     ));
}
