class Classroom {
  String id;
  int classroomNumber;
  int floor;

  Classroom({
    required this.id,
    required this.classroomNumber,
    required this.floor,
  });

  factory Classroom.fromMap(Map<String, dynamic> data, String documentId) {
    return Classroom(
      id: documentId,
      classroomNumber: data['classroomNumber'] ?? 0,
      floor: data['floor'] ?? 0,
    );
  }

  @override
  String toString() {
    return 'Classroom(id: $id, classroomNumber: $classroomNumber, floor: $floor)';
  }


}

