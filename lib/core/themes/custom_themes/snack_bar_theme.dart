import 'package:flutter/material.dart';

import '../colors.dart';
import 'text_theme.dart';

class KSnackBarTheme {
  KSnackBarTheme._();

  static final snackBarDarkTheme = SnackBarThemeData(
    backgroundColor: const Color(0xff323232),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
    elevation: 5,
    dismissDirection: DismissDirection.down,
    contentTextStyle: KTextTheme.darkTextTheme.bodyMedium?.copyWith(
      color: KColors.white,
    ),
    behavior: SnackBarBehavior.floating,
  );

  static final snackBarLightTheme = SnackBarThemeData(
    backgroundColor: const Color(0xffedede9),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
    elevation: 5,
    contentTextStyle: KTextTheme.lightTextTheme.bodyMedium?.copyWith(
      color: KColors.black,
    ),
    behavior: SnackBarBehavior.floating,
  );
}
