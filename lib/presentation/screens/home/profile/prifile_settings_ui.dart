import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinder/config/theme/color_palette.dart';
import 'package:tinder/extensions/build_context_extension.dart';
import 'package:tinder/gen/assets.gen.dart';
import 'package:tinder/presentation/app/navigation/cubit/user_session_navigation_cubit.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({Key? key}) : super(key: key);

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  bool isSwitched = false;
  double age = 22;
  RangeValues _currentRangeValues = const RangeValues(40, 80);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Assets.images.icons.tinderWhite
            .svg(color: ColorPalette.colorPrimary100),
        title: Align(
          child: Text("Settings", style: context.theme.textTheme.headline2),
          alignment: Alignment.centerLeft,
        ),
      ),
      backgroundColor: ColorPalette.grayLightest,
      body: Container(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(
                left: 8,
                right: 8,
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Text(
                        "Account settings",
                        style: context.theme.textTheme.headline3,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Phone number",
                          style: context.theme.textTheme.headline3,
                        ),
                        Text(
                          "625 246 775",
                          style: context.theme.textTheme.headline3,
                        ),
                      ],
                    ),
                    decoration: const BoxDecoration(
                      color: ColorPalette.white,
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Text(
                        "Discovery settings",
                        style: context.theme.textTheme.headline3,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Entire world",
                          style: context.theme.textTheme.headline3,
                        ),
                        Switch(
                          value: isSwitched,
                          onChanged: (value) {
                            setState(() {
                              isSwitched = value;
                            });
                          },
                        ),
                      ],
                    ),
                    decoration: const BoxDecoration(
                      color: ColorPalette.white,
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Location",
                          style: context.theme.textTheme.headline3,
                        ),
                        Text(
                          "My actual location",
                          style: context.theme.textTheme.headline3!
                              .copyWith(color: ColorPalette.blue),
                        ),
                      ],
                    ),
                    decoration: const BoxDecoration(
                      color: ColorPalette.white,
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Show me: ",
                          style: context.theme.textTheme.headline3!
                              .copyWith(color: ColorPalette.colorPrimaryBase),
                        ),
                        Text(
                          "Women",
                          style: context.theme.textTheme.headline3,
                        ),
                      ],
                    ),
                    decoration: const BoxDecoration(
                      color: ColorPalette.white,
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Align(
                          child: Text(
                            "Maximum distance: ",
                            style: context.theme.textTheme.headline2!
                                .copyWith(color: ColorPalette.colorPrimaryBase),
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 10,
                              child: Slider(
                                value: age,
                                onChanged: (value) {
                                  setState(() {
                                    age = value;
                                  });
                                },
                                min: 18,
                                max: 100,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(age.toStringAsFixed(0),
                                  style: context.theme.textTheme.headline2),
                            )
                          ],
                        )
                      ],
                    ),
                    decoration: const BoxDecoration(
                      color: ColorPalette.white,
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Align(
                          child: Text(
                            "Age range: ",
                            style: context.theme.textTheme.headline2!
                                .copyWith(color: ColorPalette.colorPrimaryBase),
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 8,
                              child: RangeSlider(
                                values: _currentRangeValues,
                                min: 18,
                                max: 100,
                                onChanged: (RangeValues values) {
                                  setState(() {
                                    _currentRangeValues = values;
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                _currentRangeValues.start.toStringAsFixed(0) +
                                    "-" +
                                    _currentRangeValues.end.toStringAsFixed(0),
                                style: context.theme.textTheme.headline2,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    decoration: const BoxDecoration(
                      color: ColorPalette.white,
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 10),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    child: ElevatedButton(
                        onPressed: () => _logOut(context),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Logout",
                            style: context.theme.textTheme.headline2,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                        )),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _logOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    context.read<UserSessionNavigationCubit>().onUserSessionStateChanged();
  }
}

//TODO: Texts to separate file