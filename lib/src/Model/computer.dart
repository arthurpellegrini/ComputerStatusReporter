class Computer {
  String id;
  String computerName;
  int classroomId;

  Computer({
    required this.id,
    required this.computerName,
    required this.classroomId,
  });

  @override
  String toString() {
    return 'Computer(id: $id, computerName: $computerName, classroomId: $classroomId)';
  }
}

