import 'package:computer_status_reporter/src/model/classroom.dart';
import 'package:computer_status_reporter/src/model/computer.dart';
import 'package:flutter/material.dart';

class MissingFormView extends StatefulWidget {
  final Classroom selectedClassroom;
  final Computer selectedComputer;

  const MissingFormView(
      {super.key,
      required this.selectedClassroom,
      required this.selectedComputer});

  @override
  MissingFormViewState createState() => MissingFormViewState();
}

class MissingFormViewState extends State<MissingFormView> {
  List<Map<String, dynamic>> items = [
    {
      'name': 'HDMI Cable',
      'selected': false,
      'icon': Icons.settings_input_hdmi
    },
    {'name': 'Keyboard', 'selected': false, 'icon': Icons.keyboard},
    {'name': 'Mouse', 'selected': false, 'icon': Icons.mouse},
    {'name': 'Power Cable', 'selected': false, 'icon': Icons.power},
    {'name': 'Monitor', 'selected': false, 'icon': Icons.desktop_mac_outlined},
    {'name': 'Ethernet Cable', 'selected': false, 'icon': Icons.router},
    {'name': 'Other', 'selected': false, 'icon': Icons.devices_other},
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

  final _formKey = GlobalKey<FormState>();

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
                'Classroom : ${widget.selectedClassroom.floor}.${widget.selectedClassroom.classroomNumber}',
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
                            ? Colors.blue.withOpacity(0.2)
                            : Colors.transparent,
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
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Comment',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                validator: (value) {
                  if (otherItemSelected()) {
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
                    if (_formKey.currentState!.validate() &&
                        isAtLeastOneItemSelected()) {
                      // TODO : Envoyer le formulaire & renvoyer vers la home page
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
