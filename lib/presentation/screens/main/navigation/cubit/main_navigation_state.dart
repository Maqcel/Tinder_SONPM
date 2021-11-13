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
