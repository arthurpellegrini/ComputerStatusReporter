import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:computer_status_reporter/firebase_options.dart';
import 'package:computer_status_reporter/src/api/classroomRequests.dart';

import 'classroom.dart';
import 'computer.dart';
import 'report.dart';

import 'package:firebase_core/firebase_core.dart';

class DataController {

  final FirebaseFirestore firestore;
  late final ClassroomRequests classroomRequests;

  DataController({required this.firestore}) {
    classroomRequests = ClassroomRequests(firestore: firestore);
  }

  // Fonction pour créer un objet Classroom
  Classroom createClassroom(String id, int classroomNumber, int floor) {
    return Classroom(id: id, classroomNumber: classroomNumber, floor: floor);
  }

  // Fonction pour retourner une liste d'objets Classroom
  Future<List<Classroom>> createClassroomsList() async {
    return classroomRequests.getClassrooms();
  }

  // Fonction pour créer un objet Computer
  Computer createComputer(String id, String computerName, int classroomId) {
    return Computer(id: id, computerName: computerName, classroomId: classroomId);
  }

  // Fonction pour retourner une liste d'objets Computer
  List<Computer> createComputersList(int count) {
    return List.generate(count, (index) => Computer(id: "index", computerName: 'Computer $index', classroomId: 100 + index));
  }

}

Future<void> main() async {

  
  //start the firebase link
  await Firebase.initializeApp( options: DefaultFirebaseOptions.currentPlatform);
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  DataController dataController = DataController(firestore: firestore);
  //end link and start app under

  // Exemple de création d'une liste d'objets Classroom
  List<Classroom> classrooms = await dataController.createClassroomsList();

  classrooms.forEach(print);
  
}
