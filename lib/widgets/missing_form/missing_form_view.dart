import 'package:computer_status_reporter/widgets/custom/custom_toast.dart';
import 'package:computer_status_reporter/model/classroom.dart';
import 'package:computer_status_reporter/model/computer.dart';
import 'package:computer_status_reporter/model/data_controller.dart';
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

  void _showSuccessToast(BuildContext context) {
    CustomToast.show(
      context,
      AppLocalizations.of(context)!.reportSuccess,
      Icons.check_circle,
      Colors.green,
    );
  }

  void _showErrorToast(BuildContext context) {
    CustomToast.show(
      context,
      AppLocalizations.of(context)!.reportTransmissionFailed,
      Icons.error,
      Colors.red,
    );
  }

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
              Container(
                constraints: const BoxConstraints(
                  maxHeight: 300,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: items.map((item) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10.0),
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          icon: Icon(
                            item['icon'],
                            size: 30,
                          ),
                          label: Text(
                            AppLocalizations.of(context)!
                                .getString(item['key'] as String),
                            style: const TextStyle(fontSize: 20),
                          ),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            backgroundColor: const Color(0xFFF3F0FF),
                            side: BorderSide(
                              color: item['selected']
                                  ? const Color(0xFF7950F2)
                                  : Colors.transparent,
                              width: 1.5,
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
                ),
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
                  onPressed: () async {
                    if (_formKey.currentState!.validate() &&
                        isAtLeastOneItemSelected()) {
                      String comment = _commentController.text;
                      List<String> selectedItems = getSelectedItems();

                      bool result =
                          await widget.dataController.addReportByFields(
                        widget.selectedClassroom,
                        widget.selectedComputer,
                        comment,
                        !selectedItems.contains('hdmiCable'),
                        !selectedItems.contains('ethernetCable'),
                        !selectedItems.contains('keyboard'),
                        !selectedItems.contains('mouse'),
                        !selectedItems.contains('powerCable'),
                        !selectedItems.contains('monitor'),
                        !selectedItems.contains('computer'),
                      );

                      if (result) {
                        _showSuccessToast(context);
                      } else {
                        _showErrorToast(context);
                      }

                      Navigator.pushNamed(context, '/');
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
