class Classroom {
  int id;
  int classroomNumber;
  int floor;

  Classroom({
    required this.id,
    required this.classroomNumber,
    required this.floor,
  });

  @override
  String toString() {
    return 'Classroom(id: $id, classroomNumber: $classroomNumber, floor: $floor)';
  }
}

