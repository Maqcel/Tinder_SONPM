part of 'home_navigation_cubit.dart';

abstract class HomeNavigationState extends Equatable {
  const HomeNavigationState();

  @override
  List<Object> get props => [];
}

class HomePeople extends HomeNavigationState {}

class HomeChat extends HomeNavigationState {}

class HomePossibleMatch extends HomeNavigationState {}

class HomeProfile extends HomeNavigationState {}
