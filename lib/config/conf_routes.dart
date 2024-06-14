import 'package:flutter/material.dart';
import 'package:computer_status_reporter/widgets/home_view.dart';
import 'package:computer_status_reporter/widgets/missing_form/select_room_view.dart';
import 'package:computer_status_reporter/widgets/listing_reports/listing_reports_view.dart';
import 'package:computer_status_reporter/widgets/settings/settings_controller.dart';
import 'package:computer_status_reporter/widgets/settings/settings_view.dart';
import 'package:computer_status_reporter/model/data_controller.dart';

class AppRoutes {
  static const home = '/';
  static const settings = '/settings';
  static const report = '/report';
  static const view = '/view';
  static const scanQR = '/scanQR';

  static Map<String, WidgetBuilder> getRoutes(SettingsController settingsController, DataController dataController) {
    return {
      home: (context) => const HomeView(),
      settings: (context) => SettingsView(controller: settingsController),
      report: (context) => SelectRoomView(dataController: dataController),
      view: (context) => ListingReportsView(dataController: dataController),
      scanQR: (context) => const Placeholder(), // Add your ScanQR page here
    };
  }
}
