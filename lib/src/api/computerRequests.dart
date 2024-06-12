import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:computer_status_reporter/src/model/computer.dart';

class ComputerRequests {
  FirebaseFirestore firestore;

  ComputerRequests({required this.firestore});

  Future<List<Computer>> getComputers() async {
    try {
      QuerySnapshot querySnapshot = await firestore.collection('Computer').orderBy("computerName", descending: false).get();
      List<Computer> computers = querySnapshot.docs.map((doc) {
        return Computer.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
      return computers;
    } catch (e) {
      print(e);
      return [];
    }
  }

}
