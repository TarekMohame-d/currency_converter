import 'package:currency_converter/core/routing/app_router.dart';
import 'package:currency_converter/core/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class App extends StatelessWidget {
  final bool isDarkMode;

  const App({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
        theme: KThemes.lightTheme,
        darkTheme: KThemes.darkTheme,
        routerConfig: appRouter,
      ),
    );
  }
}
