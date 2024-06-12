class Computer {
  int id;
  String computerName;
  int classroomId;
  List<int> positions = [];

  Computer({
    required this.id,
    required this.computerName,
    required this.classroomId,
    required this.positions,
  });

  @override
  String toString() {
    return 'Computer(id: $id, computerName: $computerName, classroomId: $classroomId, positions: $positions)';
  }
}
