import 'package:cloud_firestore/cloud_firestore.dart';

class Report {
  String id;
  Timestamp creationDate;
  String classroomId;
  String computerId;
  String classroomName;
  String computerName;
  String reportDescription;
  bool hdmiIsOk;
  bool etherIsOk;
  bool keyboardIsOk;
  bool mouseIsOk;
  bool powerIsOk;
  bool screenIsOk;
  bool computerIsOk;

  Report({
    required this.id,
    required this.creationDate,
    required this.classroomId,
    required this.computerId,
    required this.reportDescription,
    required this.hdmiIsOk,
    required this.etherIsOk,
    required this.keyboardIsOk,
    required this.mouseIsOk,
    required this.powerIsOk,
    required this.screenIsOk,
    required this.computerIsOk,
    required this.classroomName,
    required this.computerName,
  });

  factory Report.fromMap(Map<String, dynamic> data, String documentId,) {
    return Report(
      id: documentId,
      creationDate: data['creationDate'] ?? Timestamp.now(),
      classroomId: data['classroomId'] ?? "0000",
      computerId: data['computerId'] ?? "0000",
      classroomName: data['classroomName'] ?? "0000",
      computerName: data['computerName'] ?? "0000",
      reportDescription: data['reportDescription'] ?? "no desc",
      hdmiIsOk: data['hdmiIsOk'] ?? false,
      etherIsOk: data['etherIsOk'] ?? false,
      keyboardIsOk: data['keyboardIsOk'] ?? false,
      mouseIsOk: data['mouseIsOk'] ?? false,
      powerIsOk: data['powerIsOk'] ?? false,
      screenIsOk: data['screenIsOk'] ?? false,
      computerIsOk: data['computerIsOk'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'creationDate': creationDate,
      'classroomId': classroomId,
      'computerId': computerId,
      'classroomName': classroomName,
      'computerName': computerName,
      'reportDescription': reportDescription,
      'hdmiIsOk': hdmiIsOk,
      'etherIsOk': etherIsOk,
      'keyboardIsOk': keyboardIsOk,
      'mouseIsOk': mouseIsOk,
      'powerIsOk': powerIsOk,
      'screenIsOk': screenIsOk,
      'computerIsOk': computerIsOk,
    };
  }

  @override
  String toString() {
    return 'Report(id: $id, creationDate: $creationDate, classroomId: $classroomId, computerId: $computerId, '
           'reportDescription: $reportDescription, hdmiIsOk: $hdmiIsOk, etherIsOk: $etherIsOk, keyboardIsOk: $keyboardIsOk, '
           'mouseIsOk: $mouseIsOk, powerIsOk: $powerIsOk, screenIsOk: $screenIsOk, computerIsOk: $computerIsOk)';
  }
}
