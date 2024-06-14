import 'package:flutter/material.dart';
import 'package:computer_status_reporter/widgets/settings/settings_service.dart';

class SettingsController with ChangeNotifier {
  SettingsController(this._settingsService);

  final SettingsService _settingsService;

  ThemeMode _themeMode = ThemeMode.system;
  Locale _currentLocale = const Locale('en');

  ThemeMode get themeMode => _themeMode;
  Locale get currentLocale => _currentLocale;

  Future<void> loadSettings() async {
    _themeMode = await _settingsService.themeMode();
    _currentLocale = await _settingsService.currentLocale();
    notifyListeners();
  }

  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null || newThemeMode == _themeMode) return;
    _themeMode = newThemeMode;
    notifyListeners();
    await _settingsService.updateThemeMode(newThemeMode);
  }

  Future<void> updateLocale(Locale newLocale) async {
    if (newLocale == _currentLocale) return;
    _currentLocale = newLocale;
    notifyListeners();
    await _settingsService.updateLocale(newLocale);
  }
}
