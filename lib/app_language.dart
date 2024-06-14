import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AppLanguage {
  final Locale locale;
  final String name;
  final String countryCode;

  AppLanguage(this.locale, this.name, this.countryCode);
}

class AppLanguages {
  static final List<AppLanguage> languages = [
    AppLanguage(const Locale('en'), 'English', 'en'),
    AppLanguage(const Locale('fr'), 'Français', 'fr'),
  ];
}

const localizationsDelegates = [
  AppLocalizations.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];

final supportedLocales =
    AppLanguages.languages.map((lang) => lang.locale).toList();
