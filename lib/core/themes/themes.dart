import 'package:currency_converter/core/themes/custom_themes/app_bar_theme.dart';
import 'package:currency_converter/core/themes/custom_themes/snack_bar_theme.dart';
import 'package:currency_converter/core/themes/custom_themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

class KThemes {
  KThemes._();

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: KColors.primaryColor,
    scaffoldBackgroundColor: KColors.scaffoldDarkColor,
    fontFamily: 'Montserrat',
    snackBarTheme: KSnackBarTheme.snackBarDarkTheme,
    textTheme: KTextTheme.darkTextTheme,
    appBarTheme: KAppBarTheme.appBarDarkTheme,
  );

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: KColors.primaryColor,
    scaffoldBackgroundColor: KColors.scaffoldLightColor,
    fontFamily: 'Montserrat',
    snackBarTheme: KSnackBarTheme.snackBarLightTheme,
    textTheme: KTextTheme.lightTextTheme,
    appBarTheme: KAppBarTheme.appBarLightTheme,
  );

  static void setSystemUiOverlayStyle(bool isDarkMode) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: isDarkMode
            ? KColors.scaffoldDarkColor
            : KColors.scaffoldLightColor,
        statusBarIconBrightness: isDarkMode
            ? Brightness.light
            : Brightness.dark,
        systemNavigationBarIconBrightness: isDarkMode
            ? Brightness.light
            : Brightness.dark,
        systemNavigationBarColor: isDarkMode
            ? KColors.scaffoldDarkColor
            : KColors.scaffoldLightColor,
        systemNavigationBarDividerColor: isDarkMode
            ? KColors.scaffoldDarkColor
            : KColors.scaffoldLightColor,
      ),
    );
  }
}
