import 'classroom.dart';
import 'computer.dart';
import 'report.dart';

class DataController {
  // Fonction pour créer un objet Classroom
  Classroom createClassroom(int id, int classroomNumber, int floor) {
    return Classroom(id: id, classroomNumber: classroomNumber, floor: floor);
  }

  // Fonction pour retourner une liste d'objets Classroom
  List<Classroom> createClassroomsList(int count) {
    return List.generate(count, (index) => Classroom(id: index, classroomNumber: 100 + index, floor: index % 3));
  }

  // Fonction pour créer un objet Computer
  Computer createComputer(int id, String computerName, int classroomId) {
    return Computer(id: id, computerName: computerName, classroomId: classroomId);
  }

  // Fonction pour retourner une liste d'objets Computer
  List<Computer> createComputersList(int count) {
    return List.generate(count, (index) => Computer(id: index, computerName: 'Computer $index', classroomId: 100 + index));
  }

  // Fonction pour créer un objet Report
  Report createReport(int id, DateTime creationDate, int classroomId, int computerId, String reportDescription,
                      bool hdmiIsOk, bool etherIsOk, bool keyboardIsOk, bool mouseIsOk, bool powerIsOk,
                      bool screenIsOk, bool computerIsOk) {
    return Report(
      id: id,
      creationDate: creationDate,
      classroomId: classroomId,
      computerId: computerId,
      reportDescription: reportDescription,
      hdmiIsOk: hdmiIsOk,
      etherIsOk: etherIsOk,
      keyboardIsOk: keyboardIsOk,
      mouseIsOk: mouseIsOk,
      powerIsOk: powerIsOk,
      screenIsOk: screenIsOk,
      computerIsOk: computerIsOk,
    );
  }

  // Fonction pour retourner une liste d'objets Report
  List<Report> createReportsList(int count) {
    return List.generate(count, (index) => Report(
      id: index,
      creationDate: DateTime.now().add(Duration(days: index)),
      classroomId: 100 + index,
      computerId: 200 + index,
      reportDescription: 'Report $index',
      hdmiIsOk: index % 2 == 0,
      etherIsOk: index % 2 == 0,
      keyboardIsOk: index % 2 == 0,
      mouseIsOk: index % 2 == 0,
      powerIsOk: index % 2 == 0,
      screenIsOk: index % 2 == 0,
      computerIsOk: index % 2 == 0,
    ));
  }
}

void main() {
  DataController dataController = DataController();

  // Exemple de création d'un objet Classroom
  Classroom classroom = dataController.createClassroom(1, 101, 1);
  print(classroom);

  // Exemple de création d'une liste d'objets Classroom
  List<Classroom> classrooms = dataController.createClassroomsList(5);
  classrooms.forEach(print);

  // Exemple de création d'un objet Computer
  Computer computer = dataController.createComputer(1, 'Dell XPS', 101);
  print(computer);

  // Exemple de création d'une liste d'objets Computer
  List<Computer> computers = dataController.createComputersList(5);
  computers.forEach(print);

  // Exemple de création d'un objet Report
  Report report = dataController.createReport(
    1,
    DateTime.now(),
    101,
    202,
    'Initial check report',
    true,
    true,
    true,
    true,
    true,
    true,
    true,
  );
  print(report);

  // Exemple de création d'une liste d'objets Report
  List<Report> reports = dataController.createReportsList(5);
  reports.forEach(print);
}
