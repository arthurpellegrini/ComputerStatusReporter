import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:computer_status_reporter/src/model/classroom.dart';

class ClassroomRequests {
  FirebaseFirestore firestore;

  ClassroomRequests({required this.firestore});

  Future<List<Classroom>> getClassrooms() async {
    try {
      QuerySnapshot querySnapshot = await firestore.collection('Classroom').orderBy("classroomNumber", descending: false).get();
      List<Classroom> classrooms = querySnapshot.docs.map((doc) {
        return Classroom.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
      return classrooms;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
