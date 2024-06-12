import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/computer.dart';

class ComputerRequests {
  FirebaseFirestore firestore;

  ComputerRequests({required this.firestore});

  Future<List<Computer>> getComputers() async {
    try {
      QuerySnapshot querySnapshot = await firestore.collection('Computer').get();
      List<Computer> computers = querySnapshot.docs.map((doc) {
        return Computer.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
      return computers;
    } catch (e) {
      // print(e);
      return [];
    }
  }
}
