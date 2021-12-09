import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinder/config/dimensions/padding_dimension.dart';
import 'package:tinder/config/theme/color_palette.dart';
import 'package:tinder/extensions/build_context_extension.dart';
import 'package:tinder/presentation/screens/onboarding/cubit/onboarding_screen_cubit.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  /// Due to insufficient amount of time this is not made due as well as it should
  late final List<Step> _steps;

  @override
  void initState() {
    super.initState();
    context.read<OnboardingScreenCubit>().initOnboarding();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _steps = [
      Step(
        title: Text(context.localizations.onboardingStepBirthDate),
        content: _birthDateStep(),
      ),
      Step(
        title: Text(context.localizations.onboardingStepBirthDate),
        content: _birthDateStep(),
      ),
    ];
  }

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

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<OnboardingScreenCubit, OnboardingScreenState>(
        buildWhen: (previous, current) => _buildWhen(previous, current),
        builder: (context, state) => _body(state),
      );

  bool _buildWhen(
    OnboardingScreenState previous,
    OnboardingScreenState current,
  ) =>
      (current is OnboardingInProgress || current is OnboardingStatus);

  Widget _body(OnboardingScreenState state) => Scaffold(
        appBar: AppBar(
          title: Text(context.localizations.onboardingAppBarTitle),
        ),
        body: Stepper(
          steps: _steps,
          onStepCancel: () {},
          onStepContinue: () {},
          controlsBuilder: (context, {onStepCancel, onStepContinue}) => Padding(
            padding: const EdgeInsets.only(top: PaddingDimension.large),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _stepNavigationButton(onStepContinue!,
                    context.localizations.onboardingStepsNextButton),
                _stepNavigationButton(onStepCancel!,
                    context.localizations.onboardingStepsPreviousButton),
              ],
            ),
          ),
        ),
      );

  Widget _stepNavigationButton(Function() onTap, String text) => InkWell(
        onTap: () => onTap(),
        child: Padding(
          padding: const EdgeInsets.all(PaddingDimension.small),
          child: Text(
            text,
            style: context.theme.textTheme.button
                ?.copyWith(color: ColorPalette.colorPrimary100),
          ),
        ),
      );
}
