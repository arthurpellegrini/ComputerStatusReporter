import 'package:flutter/material.dart';

class SettingsService {
  Future<ThemeMode> themeMode() async => ThemeMode.system;

  Future<Locale> currentLocale() async => const Locale('en'); // Default to English

  Future<void> updateThemeMode(ThemeMode theme) async {
    // Persist theme mode to storage
  }

  Future<void> updateLocale(Locale newLocale) async {
    // Persist locale to storage
  }
}
