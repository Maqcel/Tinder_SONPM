import 'package:flutter/material.dart';
import 'package:tinder/routing/route_definition.dart';

class AppRoutes {
  static RouteDefinition entry = const RouteDefinition(
    name: '/',
    valueKey: ValueKey('entry'),
  );
  static RouteDefinition splash = const RouteDefinition(
    name: '/splash',
    valueKey: ValueKey('splash'),
  );
  static RouteDefinition login = const RouteDefinition(
    name: '/auth-login',
    valueKey: ValueKey('auth-login'),
  );
  static RouteDefinition signup = const RouteDefinition(
    name: '/auth-signup',
    valueKey: ValueKey('auth-signup'),
  );
  static RouteDefinition home = const RouteDefinition(
    name: '/home',
    valueKey: ValueKey('home'),
  );
  static RouteDefinition homePeople = const RouteDefinition(
    name: '/home/people',
    valueKey: ValueKey('people'),
  );
  static RouteDefinition homeChat = const RouteDefinition(
    name: '/home/chat',
    valueKey: ValueKey('chat'),
  );
  static RouteDefinition chatList = const RouteDefinition(
    name: '/chat/chat-list',
    valueKey: ValueKey('chat-list'),
  );
  static RouteDefinition chatListConversation = const RouteDefinition(
    name: '/chat/conversation',
    valueKey: ValueKey('conversation'),
  );
  static RouteDefinition conversationChatterProfile = const RouteDefinition(
    name: '/chat/conversation/chatter-profile',
    valueKey: ValueKey('chatter-profile'),
  );
  static RouteDefinition homePossibleMatch = const RouteDefinition(
    name: '/home/possible-match',
    valueKey: ValueKey('possible-match'),
  );
  static RouteDefinition homeProfile = const RouteDefinition(
    name: '/home/profile',
    valueKey: ValueKey('profile'),
  );
  static RouteDefinition profileSettings = const RouteDefinition(
    name: '/home/settings',
    valueKey: ValueKey('settings'),
  );
  static RouteDefinition profileDetails = const RouteDefinition(
    name: '/home/details',
    valueKey: ValueKey('details'),
  );
  static RouteDefinition possibleMatchDetails = const RouteDefinition(
    name: '/home/possible-match-details',
    valueKey: ValueKey('details'),
  );
}
