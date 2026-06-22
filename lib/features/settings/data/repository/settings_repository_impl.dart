import 'package:currency_converter/core/helpers/constants.dart';
import 'package:currency_converter/core/services/shared_pref.dart';
import 'package:currency_converter/features/settings/domain/repository/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl();

  @override
  Future<bool> isDarkTheme() async {
    var key = SharedPrefKeys.isDarkMode;
    final isDark = await SharedPref.getBool(key) ?? false;
    return isDark;
  }

  @override
  Future<void> setThemeMode(bool isDark) async {
    var key = SharedPrefKeys.isDarkMode;
    await SharedPref.setData(key, isDark);
  }
}
