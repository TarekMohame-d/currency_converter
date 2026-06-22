import '../colors.dart';
import 'package:flutter/material.dart';

class KAppBarTheme {
  KAppBarTheme._();

  static final appBarDarkTheme = AppBarTheme(
    scrolledUnderElevation: 0,
    backgroundColor: KColors.scaffoldDarkColor,
  );

  static final appBarLightTheme = AppBarTheme(
    scrolledUnderElevation: 0,
    backgroundColor: KColors.scaffoldLightColor,
  );
}
