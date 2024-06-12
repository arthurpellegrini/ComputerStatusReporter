import 'package:flutter/material.dart';
import 'package:country_flags/country_flags.dart';
import 'settings_controller.dart';
import '../app_languages.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key, required this.controller});

  static const routeName = '/settings';

  final SettingsController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Dark Mode', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 8),
                Switch(
                  value: controller.themeMode == ThemeMode.dark || (controller.themeMode == ThemeMode.system && MediaQuery.of(context).platformBrightness == Brightness.dark),
                  onChanged: (bool value) {
                    controller.updateThemeMode(
                      value ? ThemeMode.dark : ThemeMode.light,
                    );
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                const Text('Language', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 8),
                DropdownButton<Locale>(
                  underline: Container(),
                  borderRadius: BorderRadius.circular(8),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  value: controller.currentLocale,
                  onChanged: (Locale? newLocale) {
                    if (newLocale != null) {
                      controller.updateLocale(newLocale);
                    }
                  },
                  items: AppLanguages.languages.map((AppLanguage language) {
                    return DropdownMenuItem<Locale>(
                      value: language.locale,
                      child: Row(
                        children: [
                          CountryFlag.fromLanguageCode(
                            language.countryCode,
                            height: 20,
                            width: 30,
                          ),
                          const SizedBox(width: 8),
                          Text(language.name, style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                ],
            ),
          ],
        ),
      ),
    );
  }
}
