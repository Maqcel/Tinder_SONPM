import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinder/config/dimensions/animation_dimension.dart';
import 'package:tinder/config/theme/color_palette.dart';
import 'package:tinder/domain/model/chat/chat.dart';
import 'package:tinder/domain/model/user/user_profile.dart';
import 'package:tinder/extensions/build_context_extension.dart';
import 'package:tinder/gen/assets.gen.dart';
import 'package:tinder/presentation/common/screen_failure_handler.dart';
import 'package:tinder/presentation/screens/home/chat/chat_list_builder.dart';
import 'package:tinder/presentation/screens/home/chat/cubit/chat_screen_cubit.dart';
import 'package:tinder/presentation/screens/home/profile/profile_screen_ui.dart';
import 'package:tinder/presentation/screens/main/navigation/cubit/main_navigation_cubit.dart';
import 'package:tinder/routing/app_routes.dart';

import 'cubit/profile_screen_cubit.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with ScreenFailureHandler {
  @override
  void initState() {
    super.initState();
    context.read<ProfileScreenCubit>().onScreenOpened();
  }

  @override
  Widget build(BuildContext context) =>
      BlocListener<MainNavigationCubit, MainNavigationState>(
        listener: (context, state) => _onMainNavigationStateChanged(state),
        child: BlocConsumer<ProfileScreenCubit, ProfileScreenState>(
          buildWhen: (previous, current) => _buildWhen(previous, current),
          builder: (context, state) => _body(state),
          listener: (context, state) => _onStateChanged(state),
        ),
      );

  void _onMainNavigationStateChanged(MainNavigationState state) {
    if (state is MainNavigationHome &&
        state.previousRoute == AppRoutes.chatListConversation) {
      context.read<ProfileScreenCubit>().onScreenOpened();
    }
  }

  bool _buildWhen(
    ProfileScreenState previous,
    ProfileScreenState current,
  ) =>
      (current is ProfileLoading || current is ProfileLoaded);

  Widget _body(ProfileScreenState state) => Scaffold(
        appBar: AppBar(
          leading: Assets.images.icons.tinderWhite
              .svg(color: ColorPalette.colorPrimary100),
        ),
        body: AnimatedSwitcher(
          duration: AnimationDimension.durationShort,
          child: _content(context, state),
        ),
      );

  Widget _content(BuildContext context, ProfileScreenState state) {
    if (state is ProfileLoaded) {
      return _profileUI(state.profile);
    } else {
      return _loadingIndicator(context);
    }
  }

  Widget _profileUI(UserProfile profile) =>
      ProfileScreenUi(profile, () => toSettings());

  void toSettings() => context.read<MainNavigationCubit>().profileToSettings();

  Widget _loadingIndicator(BuildContext context) => Center(
        child: CircularProgressIndicator(
          color: context.theme.colorScheme.secondary,
        ),
      );

  void _onStateChanged(ProfileScreenState state) {
    if (state is ProfileLoadError) {
      handleFailureInUi(context: context, failure: state.failure);
    }
  }
}
