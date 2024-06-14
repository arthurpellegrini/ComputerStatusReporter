import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:computer_status_reporter/api/classroom_requests.dart';
import 'package:computer_status_reporter/api/computer_requests.dart';
import 'package:computer_status_reporter/api/report_requests.dart';

import 'package:computer_status_reporter/model/classroom.dart';
import 'package:computer_status_reporter/model/computer.dart';
import 'package:computer_status_reporter/model/report.dart';

class DataController {
  final FirebaseFirestore firestore;
  late final ClassroomRequests classroomRequests;
  late final ComputerRequests computerRequests;
  late final ReportRequests reportRequests;

  Map<int, List<Classroom>> cacheClassroom = {};
  Map<String, List<Computer>> cacheComputer = {};

  DataController({required this.firestore}) {
    classroomRequests = ClassroomRequests(firestore: firestore);
    computerRequests = ComputerRequests(firestore: firestore);
    reportRequests = ReportRequests(firestore: firestore);
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

  Map<int, List<Classroom>> getClassrooms() {
    return cacheClassroom;
  }

  List<Classroom>? getClassroomsByFloor(int floor) {
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

  Map<String, List<Computer>> getComputers() {
    return cacheComputer;
  }

  //ici on pourrait mettre en parametre un objet Classroom en entier en fonction de comment on veut le gerer dans la view
  //List<Computer>? getComputersByClassroom(Classroom classroom)
  List<Computer>? getComputersByClassroom(String classroomId) {
    //return cacheComputer[classroom.id];
    return cacheComputer[classroomId];
  }

  //retourne la liste des signalement du plus recent au plus ancient.
  Future<List<Report>> getReportList() async {
    return reportRequests.getReports();
  }

  //A voir si on veut passer juste les id de classroom et de computer ou si on veut passer l'objet en entier
  Future<bool> addReportByFields(
      Classroom classroom,
      Computer computer,
      String reportDescription,
      bool hdmiIsOk,
      bool etherIsOk,
      bool keyboardIsOk,
      bool mouseIsOk,
      bool powerIsOk,
      bool screenIsOk,
      bool computerIsOk) async {
    return await reportRequests.addReport(Report(
        id: "Ajout",
        creationDate: Timestamp.now(),
        classroomId: classroom.id,
        computerId: computer.id,
        reportDescription: reportDescription,
        hdmiIsOk: hdmiIsOk,
        etherIsOk: etherIsOk,
        keyboardIsOk: keyboardIsOk,
        mouseIsOk: mouseIsOk,
        powerIsOk: powerIsOk,
        screenIsOk: screenIsOk,
        computerIsOk: computerIsOk,
        computerName: computer.computerName,
        classroomName: classroom.getClassroomName()));
  }
}
