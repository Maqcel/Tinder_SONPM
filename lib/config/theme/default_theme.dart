import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tinder/config/theme/color_palette.dart';
import 'package:tinder/config/theme/default_text_styles.dart';
import 'package:tinder/config/theme/text_styles_definition.dart';
import 'package:tinder/config/theme/theme_definition.dart';

class DefaultTheme extends ThemeDefinition {
  static final TextStylesDefinition textStyles = DefaultTextStyles();

  @override
  Brightness brightness = Brightness.light;

  @override
  ColorScheme get colorScheme => ColorScheme(
        primary: ColorPalette.colorPrimaryBase,
        primaryVariant: ColorPalette.colorPrimaryBase,
        secondary: ColorPalette.gold,
        secondaryVariant: ColorPalette.gold,
        surface: ColorPalette.white,
        background: ColorPalette.white,
        error: ColorPalette.red,
        onPrimary: ColorPalette.white,
        onSecondary: ColorPalette.white,
        onSurface: ColorPalette.gray,
        onBackground: ColorPalette.gray,
        onError: ColorPalette.white,
        brightness: brightness,
      );

  @override
  Color scaffoldBackgroundColor = ColorPalette.white;

  @override
  Color disabledColor = ColorPalette.grayLight;

  @override
  Color textHintColor = ColorPalette.grayMid;

  @override
  TextTheme text = textStyles.textTheme;

  @override
  AppBarTheme appBar = AppBarTheme(
    color: ColorPalette.white,
    centerTitle: true,
    elevation: 0,
    titleTextStyle: textStyles.textNavigationBar,
  );

  @override
  BottomNavigationBarThemeData bottomNavigationBar =
      BottomNavigationBarThemeData(
    backgroundColor: ColorPalette.white,
    selectedLabelStyle: textStyles.textHeadline6.copyWith(
      color: ColorPalette.colorPrimaryBase,
      fontSize: 12,
    ),
    selectedItemColor: ColorPalette.colorPrimaryBase,
    unselectedLabelStyle: textStyles.textHeadline6,
    unselectedItemColor: ColorPalette.gray,
    showUnselectedLabels: true,
  );

  @override
  TabBarTheme tabBarTheme = TabBarTheme(
    indicator: const UnderlineTabIndicator(
      borderSide: BorderSide(
        color: ColorPalette.colorPrimaryBase,
        width: 2.0,
      ),
    ),
    indicatorSize: TabBarIndicatorSize.tab,
    labelColor: ColorPalette.colorPrimaryBase,
    labelStyle: textStyles.textTabBar,
    unselectedLabelColor: ColorPalette.black,
    unselectedLabelStyle: textStyles.textTabBar,
  );

  @override
  TextButtonThemeData textButtonTheme = TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(ColorPalette.colorPrimaryBase),
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      textStyle: MaterialStateProperty.all(textStyles.textTextButton),
      elevation: MaterialStateProperty.all(0),
    ),
  );

  @override
  TextSelectionThemeData textSelectionTheme = const TextSelectionThemeData(
    cursorColor: ColorPalette.colorPrimaryBase,
    selectionColor: ColorPalette.gold,
    selectionHandleColor: ColorPalette.colorPrimaryBase,
  );

  @override
  SnackBarThemeData get snackBarTheme => SnackBarThemeData(
        contentTextStyle: textStyles.textLabel1.copyWith(
          color: ColorPalette.white,
        ),
        backgroundColor: ColorPalette.gray,
      );

  @override
  SliderThemeData sliderTheme = SliderThemeData(
    trackHeight: 6,
    activeTrackColor: ColorPalette.colorPrimaryBase,
    inactiveTrackColor: ColorPalette.colorPrimary300,
    activeTickMarkColor: ColorPalette.white,
    inactiveTickMarkColor: ColorPalette.white,
    valueIndicatorColor: ColorPalette.gray,
    valueIndicatorTextStyle: textStyles.textHeadline5.copyWith(
      color: ColorPalette.white,
    ),
  );
}
