import 'package:flutter/material.dart';

import 'package:computer_status_reporter/widgets/app.dart';
import 'package:computer_status_reporter/model/data_controller.dart';
import 'package:computer_status_reporter/widgets/settings/settings_controller.dart';
import 'package:computer_status_reporter/widgets/settings/settings_service.dart';

import 'package:computer_status_reporter/config/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load the settings
  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();

  // Start the firebase link
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  DataController dataController = DataController(firestore: firestore);

  runApp(MyApp(
      settingsController: settingsController, dataController: dataController));
}
