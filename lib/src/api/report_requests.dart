import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:computer_status_reporter/src/model/report.dart';

class ReportRequests {
  FirebaseFirestore firestore;

  ReportRequests({required this.firestore});

  Future<List<Report>> getReports() async {
    try {
      QuerySnapshot querySnapshot = await firestore.collection('Report').orderBy("creationDate", descending: true).get();
      List<Report> reports = querySnapshot.docs.map((doc) {
        return Report.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
      return reports;
    } catch (e) {
      // print(e);
      return [];
    }
  }

  Future<bool> addReport(Report report) async {
    try {

      // Add the report to Firestore and let Firestore generate the document ID
      await firestore.collection('Report').add(report.toMap());
      return true;
    } catch (e) {
      // print(e);
      return false;
    }
  }
}
