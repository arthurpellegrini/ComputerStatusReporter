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
      positions: [data['positionX'], data['positionY'] ],
    );
  }

  
  Map<String, dynamic> toMap() {
    print(positions);
    return {
      'computerName': computerName,
      'classroomId': classroomId,
      'positionX': positions[0],
      'positionY': positions[1],
    };
  }

  @override
  String toString() {
    return 'Computer(id: $id, computerName: $computerName, classroomId: $classroomId, $positions)';
  }
}

