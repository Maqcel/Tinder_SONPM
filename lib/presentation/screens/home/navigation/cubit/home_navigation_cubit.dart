import 'package:equatable/equatable.dart';
import 'package:tinder/presentation/common/navigation/navigation_cubit.dart';
import 'package:tinder/presentation/screens/home/home_screen_page_type.dart';

part 'home_navigation_state.dart';

class HomeNavigationCubit extends NavigationCubit<HomeNavigationState> {
  HomeNavigationCubit() : super(initialState: HomePeople());

  void onSelectedPageTypeChanged(HomeScreenPageType selectedPageType) {
    switch (selectedPageType) {
      case HomeScreenPageType.people:
        emit(HomePeople());
        break;
      case HomeScreenPageType.chat:
        emit(HomeChat());
        break;
      case HomeScreenPageType.possibleMatch:
        emit(HomePossibleMatch());
        break;
      case HomeScreenPageType.profile:
        emit(HomeProfile());
        break;
    }
  }
}
