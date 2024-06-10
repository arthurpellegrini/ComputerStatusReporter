class Computer {
  String id;
  String computerName;
  String classroomId;

  Computer({
    required this.id,
    required this.computerName,
    required this.classroomId,
  });

  factory Computer.fromMap(Map<String, dynamic> data, String documentId) {
    return Computer(
      id: documentId,
      computerName: data['computerName'] ?? 0,
      classroomId: data['classroomId'] ?? 0,
    );
  }

  @override
  String toString() {
    return 'Computer(id: $id, computerName: $computerName, classroomId: $classroomId)';
  }
}

