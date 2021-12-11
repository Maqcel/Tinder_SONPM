import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinder/config/dimensions/padding_dimension.dart';
import 'package:tinder/domain/model/onboarding/gender.dart';
import 'package:tinder/domain/model/onboarding/passions.dart';
import 'package:tinder/extensions/build_context_extension.dart';
import 'package:tinder/presentation/app/navigation/cubit/user_session_navigation_cubit.dart';
import 'package:tinder/presentation/screens/onboarding/cubit/onboarding_screen_cubit.dart';
import 'package:tinder/presentation/screens/onboarding/widgets/onboarding_gender_picker.dart';
import 'package:tinder/presentation/screens/onboarding/widgets/onboarding_input_field.dart';
import 'package:tinder/presentation/screens/onboarding/widgets/onboarding_passions.dart';
import 'package:tinder/presentation/widget/button/primary_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  /// Due to insufficient amount of time this is not made due as well as it should
  final TextEditingController _bioInputController = TextEditingController();
  final TextEditingController _nameInputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<OnboardingScreenCubit>().initOnboarding();
  }

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<OnboardingScreenCubit, OnboardingScreenState>(
        buildWhen: (previous, current) => _buildWhen(previous, current),
        builder: (context, state) => _body(state),
        listener: (context, state) => _onStateChanged(state),
      );

  bool _buildWhen(
    OnboardingScreenState previous,
    OnboardingScreenState current,
  ) =>
      (current is OnboardingInProgress || current is OnboardingStatus);

  Widget _body(OnboardingScreenState state) => state is OnboardingStatus
      ? Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            title: Text(context.localizations.onboardingAppBarTitle),
          ),
          body: Padding(
            padding: const EdgeInsets.all(PaddingDimension.medium),
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                children: [
                  OnboardingPassions(
                    chosenPassions: (state).passions,
                    onChipTap: _onChipTap,
                  ),
                  const SizedBox(height: PaddingDimension.medium),
                  _birthDateStep(),
                  const SizedBox(height: PaddingDimension.medium),
                  OnboardingInputField(
                    isName: true,
                    controller: _nameInputController,
                    onInputChange: _onOnboardingDataChange,
                  ),
                  const SizedBox(height: PaddingDimension.medium),
                  OnboardingInputField(
                    isName: false,
                    controller: _bioInputController,
                    onInputChange: _onOnboardingDataChange,
                  ),
                  const SizedBox(height: PaddingDimension.medium),
                  OnboardingGenderPicker(
                    gender: state.gender,
                    chooseGender: _onGenderChange,
                  ),
                  const SizedBox(height: PaddingDimension.medium),
                  _submitButton(state),
                ],
              ),
            ),
          ),
        )
      : const CircularProgressIndicator();

  void _onChipTap(Passions passion) =>
      context.read<OnboardingScreenCubit>().changePassions(passion);

  Widget _birthDateStep() => ElevatedButton(
        onPressed: () => _onDatePressed(),
        child: Text(context.localizations.onboardingStepBirthDateButton),
      );

  Future<void> _onDatePressed() async {
    final DateTime? newPicked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(
        const Duration(days: 365 * 18),
      ),
      firstDate: DateTime(1960),
      lastDate: DateTime.now().subtract(
        const Duration(days: 365 * 18),
      ),
    );
    if (newPicked != null) {
      context.read<OnboardingScreenCubit>().changeBirthDate(newPicked);
    }
  }

  void _onOnboardingDataChange() =>
      context.read<OnboardingScreenCubit>().changeOnboardingPersonalData(
            _bioInputController.text,
            _nameInputController.text,
          );

  void _onGenderChange(Gender gender) =>
      context.read<OnboardingScreenCubit>().chooseGenderData(gender);

  Widget _submitButton(OnboardingStatus state) => Row(
        children: [
          PrimaryButton(
            text: context.localizations.onboardingSubmitButtonText,
            onPressed: () =>
                context.read<OnboardingScreenCubit>().finishOnboarding(state),
            isEnabled: state.onboardingCompleted,
          ),
        ],
      );

  void _onStateChanged(OnboardingScreenState state) {
    if (state is OnboardingInProgress) {
      context.read<UserSessionNavigationCubit>().onUserSessionStateChanged();
    }
  }
}
