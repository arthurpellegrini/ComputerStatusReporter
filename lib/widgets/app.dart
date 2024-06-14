import 'package:computer_status_reporter/app_language.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:computer_status_reporter/config/conf_routes.dart';
import 'package:computer_status_reporter/config/conf_theme.dart';
import 'package:flutter/material.dart';

import 'package:computer_status_reporter/model/data_controller.dart';
import 'package:computer_status_reporter/widgets/settings/settings_controller.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.settingsController,
    required this.dataController,
  });

  final SettingsController settingsController;
  final DataController dataController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: settingsController,
      builder: (context, child) {
        return MaterialApp(
          restorationScopeId: 'app',
          localizationsDelegates: localizationsDelegates,
          supportedLocales: supportedLocales,
          locale: settingsController.currentLocale,
          onGenerateTitle: (BuildContext context) => AppLocalizations.of(context)!.appTitle,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: settingsController.themeMode,
          initialRoute: AppRoutes.home,
          routes: AppRoutes.getRoutes(settingsController, dataController),
        );
      },
    );
  }
}
