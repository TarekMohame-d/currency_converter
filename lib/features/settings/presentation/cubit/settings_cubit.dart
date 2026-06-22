import 'package:currency_converter/features/settings/domain/repository/settings_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsCubit extends Cubit<bool> {
  final SettingsRepository _settingsRepository;

  SettingsCubit(this._settingsRepository) : super(false);

  void loadTheme() async {
    final isDark = await _settingsRepository.isDarkTheme();
    emit(isDark);
  }

  void toggleTheme(bool isDark) async {
    emit(isDark);
    await _settingsRepository.setThemeMode(isDark);
  }
}
