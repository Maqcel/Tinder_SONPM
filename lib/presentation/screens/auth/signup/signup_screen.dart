import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinder/config/dimensions/animation_dimension.dart';
import 'package:tinder/config/dimensions/padding_dimension.dart';
import 'package:tinder/domain/failures/signup_failure.dart';
import 'package:tinder/extensions/build_context_extension.dart';
import 'package:tinder/gen/assets.gen.dart';
import 'package:tinder/presentation/app/navigation/cubit/user_session_navigation_cubit.dart';
import 'package:tinder/presentation/common/screen_failure_handler.dart';
import 'package:tinder/presentation/screens/auth/signup/cubit/signup_screen_cubit.dart';
import 'package:tinder/presentation/screens/auth/widgets/email_form_input.dart';
import 'package:tinder/presentation/screens/auth/widgets/error_container.dart';
import 'package:tinder/presentation/screens/auth/widgets/password_form_input.dart';
import 'package:tinder/presentation/widget/button/primary_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> with ScreenFailureHandler {
  final TextEditingController _emailInputController = TextEditingController();
  final TextEditingController _passwordInputController =
      TextEditingController();
  final FocusNode _passwordInputFocusNode =
      FocusNode(debugLabel: 'PasswordInputFocusNode');
  @override
  Widget build(BuildContext context) =>
      BlocConsumer<SignupScreenCubit, SignupScreenState>(
        builder: (context, state) => _body(state),
        listener: (context, state) => _onStateChanged(state),
      );

  Widget _body(SignupScreenState state) => Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _tinderLogoContainer(),
            _signupFormContainer(state),
            _loginScreenChangeButton(),
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

  Widget _signupFormContainer(SignupScreenState state) => Container(
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
              onInputChange: _onSignupDataChanged,
            ),
            const SizedBox(
              height: PaddingDimension.medium,
              width: double.infinity,
            ),
            PasswordFormInput(
              hintText: context.localizations.signinInputPasswordHint,
              focusNode: _passwordInputFocusNode,
              controller: _passwordInputController,
              onInputChange: _onSignupDataChanged,
            ),
            const SizedBox(
              height: PaddingDimension.large,
              width: double.infinity,
            ),
            _signupButtonRow(state.allowSignup)
          ],
        ),
      );

  Widget _errorContainer(SignupScreenState state) => AnimatedSize(
        duration: AnimationDimension.durationMedium,
        child: (state is SignupError && state.failure is! SignupFailure)
            ? _error(state)
            : const SizedBox.shrink(),
      );

  Widget _error(SignupError state) => Column(
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

  Widget _signupButtonRow(bool allowSignup) => Row(
        children: [
          PrimaryButton(
            text: context.localizations.signupButtonSignupText,
            isEnabled: allowSignup,
            onPressed: () => _onSignupButtonClicked(),
          )
        ],
      );

  void _onEmailInputEditingComplete() {
    context.focusScope.requestFocus(_passwordInputFocusNode);
  }

  void _onSignupDataChanged() {
    String email = _emailInputController.text;
    String password = _passwordInputController.text;
    context.read<SignupScreenCubit>().onSignupDataChanged(email, password);
  }

  void _onSignupButtonClicked() {
    String email = _emailInputController.text;
    String password = _passwordInputController.text;
    context.focusScope.unfocus();
    context.read<SignupScreenCubit>().onSignupButtonClicked(email, password);
  }

  Widget _loginScreenChangeButton() => TextButton(
        onPressed: () => context.navigator.maybePop(),
        child: Text(context.localizations.signupScreenChangeButton),
      );

  void _onStateChanged(SignupScreenState state) {
    if (state is SignupSuccess) {
      context.read<UserSessionNavigationCubit>().onUserSessionStateChanged();
    } else if (state is SignupError) {
      handleFailureInUi(context: context, failure: state.failure);
    }
  }
}
