abstract class SettingsRepository {
  Future<bool> isDarkTheme();
  Future<void> setThemeMode(bool isDark);
}
