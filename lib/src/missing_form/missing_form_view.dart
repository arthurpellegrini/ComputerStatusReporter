import 'package:computer_status_reporter/src/model/classroom.dart';
import 'package:computer_status_reporter/src/model/computer.dart';
import 'package:computer_status_reporter/src/model/data_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    {'key': 'hdmiCable', 'selected': false, 'icon': Icons.settings_input_hdmi},
    {'key': 'keyboard', 'selected': false, 'icon': Icons.keyboard},
    {'key': 'mouse', 'selected': false, 'icon': Icons.mouse},
    {'key': 'powerCable', 'selected': false, 'icon': Icons.power},
    {'key': 'monitor', 'selected': false, 'icon': Icons.desktop_mac_outlined},
    {'key': 'ethernetCable', 'selected': false, 'icon': Icons.wifi_outlined},
    {'key': 'computer', 'selected': false, 'icon': Icons.devices_other},
  ];

  bool isAtLeastOneItemSelected() {
    return items.any((item) => item['selected']);
  }

  bool otherItemSelected() {
    return items.any((item) => item['selected'] && item['key'] == 'other');
  }

  bool noItemSelected() {
    return items.every((item) => !item['selected']);
  }

  List<String> getSelectedItems() {
    return items
        .where((item) => item['selected'])
        .map((item) => item['key'] as String)
        .toList();
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
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.missingFormTitle),
      ),
      body: Container(
        margin: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Text(
                '${localizations.classroom}: ${widget.selectedClassroom.getClassroomName()}',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                '${localizations.computer}: ${widget.selectedComputer.computerName}',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Wrap(
                children: items.map((item) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10.0),
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      icon: Icon(item['icon']),
                      label: Text(AppLocalizations.of(context)!
                          .getString(item['key'] as String)),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        backgroundColor: item['selected']
                            ? const Color.fromARGB(255, 233, 136, 98)
                                .withOpacity(0.2)
                            : const Color.fromARGB(202, 186, 241, 84),
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
                decoration: InputDecoration(
                  labelText: localizations.commentLabel,
                  border: const OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                validator: (value) {
                  if (otherItemSelected() && value!.isEmpty) {
                    return localizations.commentHint;
                  } else if (noItemSelected()) {
                    return localizations.selectAtLeastOneItemHint;
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
                      String comment = _commentController.text;
                      List<String> selectedItems = getSelectedItems();

                      widget.dataController.addReportByFields(
                        widget.selectedClassroom,
                        widget.selectedComputer,
                        comment,
                        selectedItems.contains('hdmiCable') ? false : true,
                        selectedItems.contains('ethernetCable') ? false : true,
                        selectedItems.contains('keyboard') ? false : true,
                        selectedItems.contains('mouse') ? false : true,
                        selectedItems.contains('powerCable') ? false : true,
                        selectedItems.contains('monitor') ? false : true,
                        selectedItems.contains('computer') ? false : true,
                      );

                      Navigator.pop(context);
                    }
                  },
                  child: Text(localizations.sendButtonLabel),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension AppLocalizationsExtension on AppLocalizations {
  String getString(String key) {
    switch (key) {
      case 'hdmiCable':
        return hdmiCable;
      case 'keyboard':
        return keyboard;
      case 'mouse':
        return mouse;
      case 'powerCable':
        return powerCable;
      case 'monitor':
        return monitor;
      case 'ethernetCable':
        return ethernetCable;
      case 'computer':
        return computer;
      default:
        return '';
    }
  }
}
