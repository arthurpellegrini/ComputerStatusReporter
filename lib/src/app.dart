
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:computer_status_reporter/src/home_view.dart';
import 'package:computer_status_reporter/src/missing_form/select_room_view.dart';
import 'package:computer_status_reporter/src/model/data_controller.dart';
import 'package:computer_status_reporter/src/settings/settings_controller.dart';
import 'package:computer_status_reporter/src/settings/settings_view.dart';

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
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
            Locale('fr', ''),
          ],
          locale: settingsController.currentLocale,
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,
          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: settingsController.themeMode,
          initialRoute: '/',
          routes: {
            '/': (context) => const HomeView(),
            '/settings': (context) => SettingsView(controller: settingsController),
            '/report': (context) => SelectRoomView(dataController: dataController), // Add your Report page here
            '/view': (context) => const Placeholder(), // Add your View page here
            '/scanQR': (context) => const Placeholder(), // Add your ScanQR page here
          },
        );
      },
    );
  }
}
