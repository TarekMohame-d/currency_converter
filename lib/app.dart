import 'package:currency_converter/core/routing/app_router.dart';
import 'package:currency_converter/core/themes/themes.dart';
import 'package:currency_converter/core/service_locator/dependency_injection.dart';
import 'package:currency_converter/features/settings/domain/repository/settings_repository.dart';
import 'package:currency_converter/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingsCubit>(
      create: (_) => SettingsCubit(getIt<SettingsRepository>()),
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        builder: (context, child) {
          return BlocBuilder<SettingsCubit, bool>(
            builder: (context, isDarkMode) {
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
                theme: KThemes.lightTheme,
                darkTheme: KThemes.darkTheme,
                routerConfig: appRouter,
              );
            },
          );
        },
      ),
    );
  }
}
