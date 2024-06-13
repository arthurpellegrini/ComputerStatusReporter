import 'package:computer_status_reporter/src/model/data_controller.dart';
import 'package:flutter/material.dart';
import 'package:computer_status_reporter/src/model/report.dart';

class ListingReportsView extends StatelessWidget {
  final DataController dataController;

  const ListingReportsView({Key? key, required this.dataController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Report>>(
      future: dataController.getReportList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Erreur : ${snapshot.error}');
        } else {
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final report = snapshot.data![index];
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Report ID: ${report.id}',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(
                          'information : Classroom => ${report.classroomName}, Computer => ${report.computerName}'),
                      Text(
                          'Description: ${report.reportDescription.isNotEmpty ? report.reportDescription : 'No description'}'),
                      Wrap(
                        spacing: 8.0,
                        children: <Widget>[
                          if (!report.hdmiIsOk)
                            Chip(
                              avatar: Icon(Icons.error, color: Colors.red),
                              label: Text('HDMI'),
                            ),
                          if (!report.etherIsOk)
                            Chip(
                              avatar: Icon(Icons.error, color: Colors.red),
                              label: Text('Ethernet'),
                            ),
                          if (!report.keyboardIsOk)
                            Chip(
                              avatar: Icon(Icons.error, color: Colors.red),
                              label: Text('Keyboard'),
                            ),
                          if (!report.mouseIsOk)
                            Chip(
                              avatar: Icon(Icons.error, color: Colors.red),
                              label: Text('Mouse'),
                            ),
                          if (!report.powerIsOk)
                            Chip(
                              avatar: Icon(Icons.error, color: Colors.red),
                              label: Text('Power'),
                            ),
                          if (!report.screenIsOk)
                            Chip(
                              avatar: Icon(Icons.error, color: Colors.red),
                              label: Text('Screen'),
                            ),
                          if (!report.computerIsOk)
                            Chip(
                              avatar: Icon(Icons.error, color: Colors.red),
                              label: Text('Computer'),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
