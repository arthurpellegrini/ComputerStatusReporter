class Computer {
  String id;
  String computerName;
  String classroomId;
  List<int> positions = [];

  Computer({
    required this.id,
    required this.computerName,
    required this.classroomId,
    required this.positions,
  });

  factory Computer.fromMap(Map<String, dynamic> data, String documentId) {
    return Computer(
      id: documentId,
      computerName: data['computerName'] ?? "00-00-00",
      classroomId: data['classroomId'] ?? "0000",
      positions: List<int>.from(data['positions'] ?? []),
    );
  }

  @override
  String toString() {
    return 'Computer(id: $id, computerName: $computerName, classroomId: $classroomId, positions: $positions)';
  }
}
