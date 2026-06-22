import 'package:currency_converter/app.dart';
import 'package:currency_converter/core/helpers/constants.dart';
import 'package:currency_converter/core/service_locator/dependency_injection.dart';
import 'package:currency_converter/core/services/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupGetIt();

  await ScreenUtil.ensureScreenSize();

  bool isDarkMode =
      await SharedPref.getBool(SharedPrefKeys.isDarkMode) ?? false;

  runApp(App(isDarkMode: isDarkMode));
}
