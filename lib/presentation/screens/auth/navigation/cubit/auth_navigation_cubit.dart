import 'package:equatable/equatable.dart';
import 'package:tinder/presentation/common/navigation/navigation_cubit.dart';
import 'package:tinder/routing/app_routes.dart';

part 'auth_navigation_state.dart';

class AuthNavigationCubit extends NavigationCubit<AuthNavigationState> {
  AuthNavigationCubit() : super(initialState: AuthNavigationLogin());

  @override
  void onRoutePop(String? routeName) {
    if (routeName == AppRoutes.signup.name) {
      emit(AuthNavigationLogin());
    } else {
      onUnknownRouteName(routeName);
    }
  }

  void loginToSignup() => emit(AuthNavigationSignup());
}
