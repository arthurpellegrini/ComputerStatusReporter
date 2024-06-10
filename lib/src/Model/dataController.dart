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
  Map<int,  List<Classroom>> cacheClassroom = {};


  DataController({required this.firestore}) {
    classroomRequests = ClassroomRequests(firestore: firestore);
  }

    // Fonction pour retourner une liste d'objets Classroom
  Future<void> createClassroomsList() async {

      List<Classroom> classrooms = await classroomRequests.getClassrooms();

    cacheClassroom.clear();
    for (var classroom in classrooms) {
      if (!cacheClassroom.containsKey(classroom.floor)) {
        cacheClassroom[classroom.floor] = [];
      }
      cacheClassroom[classroom.floor]!.add(classroom);
    } 
        
  }

  Map<int,  List<Classroom>> getClassrooms(){
    return cacheClassroom;
  }

  List<Classroom>? getClassroomsByFloor(int floor)
  {
    return cacheClassroom[floor];
  }




  /* A PARTIR D'ICI CE SONT DES FONCTIONS TEMPORAIRES UNIQUEMENT POUR LES TESTS */

  // Fonction pour créer un objet Classroom
  Classroom createClassroom(String id, int classroomNumber, int floor) {
    return Classroom(id: id, classroomNumber: classroomNumber, floor: floor);
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
  await dataController.createClassroomsList();
  // Exemple de création d'une liste d'objets Classroom
  Map<int, dynamic> classrooms = dataController.getClassrooms();

  print(classrooms.toString());
  
}
