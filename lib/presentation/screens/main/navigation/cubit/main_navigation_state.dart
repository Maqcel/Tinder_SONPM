part of 'main_navigation_cubit.dart';

abstract class MainNavigationState extends Equatable {
  final RouteDefinition? previousRoute;

  const MainNavigationState({required this.previousRoute});

  @override
  List<Object?> get props => [previousRoute];
}

class MainNavigationHome extends MainNavigationState {
  const MainNavigationHome({
    required RouteDefinition previousRoute,
  }) : super(
          previousRoute: previousRoute,
        );
}

class MainNavigationChatConversation extends MainNavigationState {
  final Chat chat;

  const MainNavigationChatConversation({
    required this.chat,
    required RouteDefinition previousRoute,
  }) : super(
          previousRoute: previousRoute,
        );

  @override
  List<Object> get props => [chat];
}

class MainNavigationSettings extends MainNavigationState {
  const MainNavigationSettings({
    required RouteDefinition previousRoute,
  }) : super(
          previousRoute: previousRoute,
        );
}

class MainNavigationPossibleMatchDetails extends MainNavigationState {
  const MainNavigationPossibleMatchDetails({
    required RouteDefinition previousRoute,
  }) : super(
    previousRoute: previousRoute,
  );
}

class MainNavigationDetails extends MainNavigationState {
  final UserProfile profile;
  const MainNavigationDetails({
    required this.profile,
    required RouteDefinition previousRoute,
  }) : super(
          previousRoute: previousRoute,
        );
}

class MainNavigationMatchDetails extends MainNavigationState {
  final PossibleMatch profile;
  const MainNavigationMatchDetails({
    required this.profile,
    required RouteDefinition previousRoute,
  }) : super(
    previousRoute: previousRoute,
  );
}
