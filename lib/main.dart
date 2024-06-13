import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:computer_status_reporter/src/missing_form/select_room_view.dart';
import 'package:computer_status_reporter/src/model/dataController.dart';
import 'package:flutter/material.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();
  
  //start the firebase link
  //il faut absolument laisser ces trois lignes. Et pour l'app principal il faudrait lui donner en atribut le dataController.
  await Firebase.initializeApp( options: DefaultFirebaseOptions.currentPlatform);
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  DataController dataController = DataController(firestore: firestore);
  
  runApp(MyApp(dataController: dataController));
}

class MyApp extends StatelessWidget {
  final DataController dataController;

  const MyApp({Key? key, required this.dataController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Computer Status Reporter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SelectRoomView(dataController: dataController),
    );
  }
}
