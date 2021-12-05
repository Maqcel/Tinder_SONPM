import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinder/config/dimensions/animation_dimension.dart';
import 'package:tinder/config/dimensions/padding_dimension.dart';
import 'package:tinder/domain/failures/login_failure.dart';
import 'package:tinder/extensions/build_context_extension.dart';
import 'package:tinder/gen/assets.gen.dart';
import 'package:tinder/presentation/app/navigation/cubit/user_session_navigation_cubit.dart';
import 'package:tinder/presentation/common/screen_failure_handler.dart';
import 'package:tinder/presentation/screens/auth/login/cubit/login_screen_cubit.dart';
import 'package:tinder/presentation/screens/auth/navigation/cubit/auth_navigation_cubit.dart';
import 'package:tinder/presentation/screens/auth/widgets/email_form_input.dart';
import 'package:tinder/presentation/screens/auth/widgets/error_container.dart';
import 'package:tinder/presentation/screens/auth/widgets/password_form_input.dart';
import 'package:tinder/presentation/widget/button/primary_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with ScreenFailureHandler {
  final TextEditingController _emailInputController = TextEditingController();
  final TextEditingController _passwordInputController =
      TextEditingController();
  final FocusNode _passwordInputFocusNode =
      FocusNode(debugLabel: 'PasswordInputFocusNode');

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<LoginScreenCubit, LoginScreenState>(
        builder: (context, state) => _body(state),
        listener: (context, state) => _onStateChanged(state),
      );

  Widget _body(LoginScreenState state) => Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _tinderLogoContainer(),
            _loginFormContainer(state),
            _signupScreenChangeButton(),
          ],
        ),
      );

  Widget _tinderLogoContainer() => Flexible(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.width,
          ),
          color: context.theme.colorScheme.primary,
          child: FractionallySizedBox(
            heightFactor: 1,
            widthFactor: 0.5,
            child: Assets.images.icons.tinderWhite.svg(
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      );

  Widget _loginFormContainer(LoginScreenState state) => Container(
        color: context.theme.colorScheme.background,
        padding: const EdgeInsets.all(PaddingDimension.medium),
        child: Column(
          children: [
            _errorContainer(state),
            _emailLabelRow(),
            const SizedBox(
              height: PaddingDimension.small,
              width: double.infinity,
            ),
            EmailFormInput(
              controller: _emailInputController,
              onEditingComplete: () => _onEmailInputEditingComplete(),
              onInputChange: _onLoginDataChanged,
            ),
            const SizedBox(
              height: PaddingDimension.medium,
              width: double.infinity,
            ),
            PasswordFormInput(
              hintText: context.localizations.signinInputPasswordHint,
              focusNode: _passwordInputFocusNode,
              controller: _passwordInputController,
              onInputChange: _onLoginDataChanged,
            ),
            const SizedBox(
              height: PaddingDimension.large,
              width: double.infinity,
            ),
            _loginButtonRow(state.allowLogin)
          ],
        ),
      );

  Widget _errorContainer(LoginScreenState state) => AnimatedSize(
        duration: AnimationDimension.durationMedium,
        child: (state is LoginError && state.failure is! LoginFailure)
            ? _error(state)
            : const SizedBox.shrink(),
      );

  Widget _error(LoginError state) => Column(
        children: [
          ErrorContainer(
            message: state.failure.message,
          ),
          const SizedBox(
            height: PaddingDimension.medium,
            width: double.infinity,
          ),
        ],
      );

  Widget _emailLabelRow() => Row(
        children: [
          Text(
            context.localizations.signinInputEmailLabel,
            style: context.theme.textTheme.subtitle1,
          )
        ],
      );

  Widget _loginButtonRow(bool allowLogin) => Row(
        children: [
          PrimaryButton(
            text: context.localizations.signinButtonLoginText,
            isEnabled: allowLogin,
            onPressed: () => _onLoginButtonClicked(),
          )
        ],
      );

  void _onEmailInputEditingComplete() {
    context.focusScope.requestFocus(_passwordInputFocusNode);
  }

  void _onLoginDataChanged() {
    String email = _emailInputController.text;
    String password = _passwordInputController.text;
    context.read<LoginScreenCubit>().onLoginDataChanged(email, password);
  }

  void _onLoginButtonClicked() {
    String email = _emailInputController.text;
    String password = _passwordInputController.text;
    context.focusScope.unfocus();
    context.read<LoginScreenCubit>().onLoginButtonClicked(email, password);
  }

  Widget _signupScreenChangeButton() => TextButton(
        onPressed: () => context.read<AuthNavigationCubit>().loginToSignup(),
        child: Text(context.localizations.signinScreenChangeButton),
      );

  void _onStateChanged(LoginScreenState state) {
    if (state is LoginSuccess) {
      context.read<UserSessionNavigationCubit>().onUserSessionStateChanged();
    } else if (state is LoginError && state.failure is! LoginFailure) {
      handleFailureInUi(context: context, failure: state.failure);
    }
  }
}
