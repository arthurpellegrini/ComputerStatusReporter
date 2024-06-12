import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/classroom.dart';

class ClassroomRequests {
  FirebaseFirestore firestore;

  ClassroomRequests({required this.firestore});

  Future<List<Classroom>> getClassrooms() async {
    try {
      QuerySnapshot querySnapshot = await firestore.collection('Classroom').get();
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