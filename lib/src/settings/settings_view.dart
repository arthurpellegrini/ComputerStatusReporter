import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:country_flags/country_flags.dart';
import 'settings_controller.dart';
import '../app_languages.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key, required this.controller});

  static const routeName = '/settings';
  final SettingsController controller;

  final TextStyle textStyle = const TextStyle(fontSize: 16);
  final SizedBox separationSizedBox = const SizedBox(height: 10);

  Widget darkModeSwitch(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(AppLocalizations.of(context)!.appSettingsDarkMode,
            style: textStyle),
        separationSizedBox,
        Switch(
          value: controller.themeMode == ThemeMode.dark ||
              (controller.themeMode == ThemeMode.system &&
                  MediaQuery.of(context).platformBrightness == Brightness.dark),
          onChanged: (bool value) {
            controller.updateThemeMode(
              value ? ThemeMode.dark : ThemeMode.light,
            );
          },
        ),
      ],
    );
  }

  Widget languageSelection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(AppLocalizations.of(context)!.appSettingsLanguage,
            style: textStyle),
        separationSizedBox,
        DropdownButton<Locale>(
          key: ValueKey(AppLanguages.languages.length),
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
                  separationSizedBox,
                  Text(language.name, style: textStyle),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(AppLocalizations.of(context)!.appSettings, style: textStyle),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            darkModeSwitch(context),
            separationSizedBox,
            languageSelection(context),
            const Spacer(),
            Text(
              AppLocalizations.of(context)!.appCopyRights,
              style: textStyle,
            ),
            separationSizedBox,
          ],
        ),
      ),
    );
  }
}
