import 'package:flutter/material.dart';

class AppLanguage {
  final Locale locale;
  final String name;
  final String countryCode;

  AppLanguage(this.locale, this.name, this.countryCode);
}

class AppLanguages {
  static final List<AppLanguage> languages = [
    AppLanguage(const Locale('en'), 'English', 'en'),
    AppLanguage(const Locale('fr'), 'French', 'fr'),
    // Ajoutez d'autres langues ici
  ];
}
