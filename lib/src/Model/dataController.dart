import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:computer_status_reporter/firebase_options.dart';

import 'package:computer_status_reporter/src/api/classroomRequests.dart';
import 'package:computer_status_reporter/src/api/computerRequests.dart';

import 'classroom.dart';
import 'computer.dart';
import 'report.dart';

import 'package:firebase_core/firebase_core.dart';

class DataController {

  final FirebaseFirestore firestore;
  late final ClassroomRequests classroomRequests;
  late final ComputerRequests computerRequests;

  Map<int,  List<Classroom>> cacheClassroom = {};
  Map<String,  List<Computer>> cacheComputer = {};


  DataController({required this.firestore}) {
    classroomRequests = ClassroomRequests(firestore: firestore);
    computerRequests = ComputerRequests(firestore: firestore);
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

      // Fonction pour retourner une liste d'objets Computer
  Future<void> createComputersList() async {

      List<Computer> computers = await computerRequests.getComputers();

    cacheComputer.clear();
    for (var computer in computers) {
      if (!cacheComputer.containsKey(computer.classroomId)) {
        cacheComputer[computer.classroomId] = [];
      }
      cacheComputer[computer.classroomId]!.add(computer);
    } 
        
  }

  Map<String,  List<Computer>> getComputers(){
    return cacheComputer;
  }

  //ici on pourrait mettre en parametre un objet Classroom en entier en fonction de comment on veut le gerer dans la view
  //List<Computer>? getComputersByClassroom(Classroom classroom)
  List<Computer>? getComputersByClassroom(String classroomId)
  {
    //return cacheComputer[classroom.id];
    return cacheComputer[classroomId];
  }

  /* A PARTIR D'ICI CE SONT DES FONCTIONS TEMPORAIRES UNIQUEMENT POUR LES TESTS */

  // Fonction pour créer un objet Classroom
  Classroom createClassroom(String id, int classroomNumber, int floor) {
    return Classroom(id: id, classroomNumber: classroomNumber, floor: floor);
  }

  // Fonction pour créer un objet Computer
  Computer createComputer(String id, String computerName, String classroomId) {
    return Computer(id: id, computerName: computerName, classroomId: classroomId);
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
  

  
  await dataController.createComputersList();
  // Exemple de création d'une liste d'objets Computer
  Map<String, dynamic> computers = dataController.getComputers();

  print(computers.toString());
}
