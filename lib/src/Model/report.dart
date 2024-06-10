
class Report {
  String id;
  DateTime creationDate;
  int classroomId;
  int computerId;
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
  });

  @override
  String toString() {
    return 'Report(id: $id, creationDate: $creationDate, classroomId: $classroomId, computerId: $computerId, '
           'reportDescription: $reportDescription, hdmiIsOk: $hdmiIsOk, etherIsOk: $etherIsOk, keyboardIsOk: $keyboardIsOk, '
           'mouseIsOk: $mouseIsOk, powerIsOk: $powerIsOk, screenIsOk: $screenIsOk, computerIsOk: $computerIsOk)';
  }
}

