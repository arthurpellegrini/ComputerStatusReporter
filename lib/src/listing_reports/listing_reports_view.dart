import 'package:flutter/material.dart';
import 'package:computer_status_reporter/src/model/data_controller.dart';
import 'package:computer_status_reporter/src/model/report.dart';

class ListingReportsView extends StatelessWidget {
  final DataController dataController;

  const ListingReportsView({Key? key, required this.dataController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reports'),
      ),
      backgroundColor: Color(0xFFF7F7F7),
      body: FutureBuilder<List<Report>>(
        future: dataController.getReportList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          } else {
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final report = snapshot.data![index];
                return _buildReportItem(report);
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildReportItem(Report report) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF9D8CCF), width: 2.5),
        borderRadius: BorderRadius.circular(8.0),
        color: Color.fromARGB(80, 218, 212, 237),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Report ID: ${report.id}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 12.0),
            _buildInfoRow(
                Icons.school_outlined, 'Classroom', report.classroomName),
            SizedBox(height: 8.0),
            _buildInfoRow(
                Icons.laptop_mac_outlined, 'Computer', report.computerName),
            SizedBox(height: 12.0),
            Text(
              'Description: ${report.reportDescription.isNotEmpty ? report.reportDescription : 'No description...'}',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 12.0),
            _buildChipRow(report),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String title, String value) {
    return Row(
      children: <Widget>[
        Icon(icon, color: Color(0xFF9D8CCF)),
        SizedBox(width: 8.0),
        Text(
          '$title: $value',
          style: TextStyle(fontSize: 16.0),
        ),
      ],
    );
  }

  Widget _buildChipRow(Report report) {
    List<Widget> chips = [];

    if (!report.hdmiIsOk) {
      chips.add(_buildStatusChip(
          report.hdmiIsOk, Icons.settings_input_hdmi_outlined, 'HDMI'));
    }
    if (!report.etherIsOk) {
      chips.add(
          _buildStatusChip(report.etherIsOk, Icons.wifi_outlined, 'Ethernet'));
    }
    if (!report.keyboardIsOk) {
      chips.add(_buildStatusChip(
          report.keyboardIsOk, Icons.keyboard_outlined, 'Keyboard'));
    }
    if (!report.mouseIsOk) {
      chips.add(
          _buildStatusChip(report.mouseIsOk, Icons.mouse_outlined, 'Mouse'));
    }
    if (!report.powerIsOk) {
      chips.add(
          _buildStatusChip(report.powerIsOk, Icons.power_outlined, 'Power'));
    }
    if (!report.screenIsOk) {
      chips.add(_buildStatusChip(
          report.screenIsOk, Icons.desktop_windows_outlined, 'Screen'));
    }
    if (!report.computerIsOk) {
      chips.add(_buildStatusChip(
          report.computerIsOk, Icons.computer_outlined, 'Computer'));
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        children: chips,
      ),
    );
  }

  Widget _buildStatusChip(bool isOk, IconData icon, String label) {
    if (!isOk) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Chip(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
            side: BorderSide(
              width: 1.5,
              color: Color(0xFF9D8CCF),
            ),
          ),
          avatar: Icon(icon, color: Color(0xFF9D8CCF)),
          label: Text(label),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }
}
