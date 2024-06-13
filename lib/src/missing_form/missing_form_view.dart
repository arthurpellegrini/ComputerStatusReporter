import 'package:computer_status_reporter/src/model/classroom.dart';
import 'package:computer_status_reporter/src/model/computer.dart';
import 'package:computer_status_reporter/src/model/data_controller.dart';
import 'package:flutter/material.dart';

class MissingFormView extends StatefulWidget {
  final Classroom selectedClassroom;
  final Computer selectedComputer;
  final DataController dataController;

  const MissingFormView(
      {super.key,
      required this.selectedClassroom,
      required this.selectedComputer,
      required this.dataController});

  @override
  MissingFormViewState createState() => MissingFormViewState();
}

class MissingFormViewState extends State<MissingFormView> {
  List<Map<String, dynamic>> items = [
    {'name': 'HDMI Cable', 'selected': false, 'icon': Icons.settings_input_hdmi},
    {'name': 'Keyboard', 'selected': false, 'icon': Icons.keyboard},
    {'name': 'Mouse', 'selected': false, 'icon': Icons.mouse},
    {'name': 'Power Cable', 'selected': false, 'icon': Icons.power},
    {'name': 'Monitor', 'selected': false, 'icon': Icons.desktop_mac_outlined},
    {'name': 'Ethernet Cable', 'selected': false, 'icon': Icons.router},
    {'name': 'Computer', 'selected': false, 'icon': Icons.devices_other},
  ];

  bool isAtLeastOneItemSelected() {
    return items.any((item) => item['selected']);
  }

  bool otherItemSelected() {
    return items.any((item) => item['selected'] && item['name'] == 'Other');
  }

  bool noItemSelected() {
    return items.every((item) => !item['selected']);
  }

  List<String> getSelectedItems() {
    return items.where((item) => item['selected']).map((item) => item['name'] as String).toList();
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Missing Form Items'),
      ),
      body: Container(
        margin: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Text(
                'Classroom : ${widget.selectedClassroom.getClassroomName()}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                'Computer : ${widget.selectedComputer.computerName}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Wrap(
                children: items.map((item) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10.0),
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      icon: Icon(item['icon']),
                      label: Text(item['name']),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        backgroundColor: item['selected']
                            ? Color.fromARGB(255, 233, 136, 98).withOpacity(0.2)
                            : Color.fromARGB(202, 186, 241, 84),
                        side: BorderSide(
                          color: item['selected'] ? Colors.blue : Colors.grey,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          item['selected'] = !item['selected'];
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _commentController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Comment',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                validator: (value) {
                  if (otherItemSelected() && value!.isEmpty) {
                    return 'Please enter a comment when you select "Other" item';
                  } else if (noItemSelected()) {
                    return 'Please select at least one item';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate() && isAtLeastOneItemSelected()) {
                      String comment = _commentController.text;
                      List<String> selectedItems = getSelectedItems();

                      widget.dataController.addReportByFields(
                        widget.selectedClassroom,
                        widget.selectedComputer,
                        comment,
                        selectedItems.contains('HDMI Cable')  ? false : true,
                        selectedItems.contains('Ethernet Cable')  ? false : true,
                        selectedItems.contains('Keyboard')  ? false : true,
                        selectedItems.contains('Mouse')  ? false : true,
                        selectedItems.contains('Power Cable')  ? false : true,
                        selectedItems.contains('Monitor')  ? false : true,
                        selectedItems.contains('Computer') ? false : true,
                      );

                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Envoyer'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
