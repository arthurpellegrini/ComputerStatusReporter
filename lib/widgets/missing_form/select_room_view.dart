import 'package:flutter/material.dart';
import 'package:computer_status_reporter/widgets/missing_form/select_post_view.dart';
import 'package:computer_status_reporter/model/data_controller.dart';
import 'package:computer_status_reporter/model/classroom.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SelectRoomView extends StatefulWidget {
  final DataController dataController;

  const SelectRoomView({super.key, required this.dataController});

  @override
  _SelectRoomViewState createState() => _SelectRoomViewState();
}

class _SelectRoomViewState extends State<SelectRoomView> {
  Map<int, List<Classroom>> classroomsByFloor = {};
  final Map<int, bool> _isExpanded = {};

  @override
  void initState() {
    super.initState();
    createData();
  }

  void createData() async {
    await widget.dataController.createClassroomsList();
    await widget.dataController.createComputersList();

    setState(() {
      classroomsByFloor = widget.dataController.getClassrooms();
      for (var key in classroomsByFloor.keys) {
        _isExpanded[key] = false;
      }
    });
  }

  void _navigateToMissingFormView(Classroom selectedClassroom) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SelectPostView(
          dataController: widget.dataController,
          selectedClassroom: selectedClassroom,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.selectClassroom),
      ),
      backgroundColor: const Color(0xFFF7F7F7),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(localizations.selectAClassroom),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.separated(
                itemCount: classroomsByFloor.keys.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16.0),
                itemBuilder: (context, index) {
                  int floor = classroomsByFloor.keys.elementAt(index);
                  return Container(
                    decoration: BoxDecoration(
                      color: _isExpanded[floor] == true
                          ? const Color(0xFFF3F0FF)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Theme(
                      data: ThemeData(
                        dividerColor: Colors.transparent,
                        primaryColor: const Color(0xFF7950f2),
                      ),
                      child: ExpansionTile(
                        leading: Icon(
                          Icons.layers,
                          color: _isExpanded[floor] == true
                              ? const Color(0xFF7950f2)
                              : Colors.black,
                        ),
                        title: Text(
                          '${localizations.floor} $floor',
                          style: TextStyle(
                            color: _isExpanded[floor] == true
                                ? const Color(0xFF7950f2)
                                : Colors.black,
                          ),
                        ),
                        onExpansionChanged: (isExpanded) {
                          setState(() {
                            _isExpanded[floor] = isExpanded;
                          });
                        },
                        initiallyExpanded: _isExpanded[floor]!,
                        collapsedTextColor: Colors.black,
                        iconColor: _isExpanded[floor] == true
                            ? const Color(0xFF7950f2)
                            : Colors.black,
                        children: classroomsByFloor[floor]!.map((classroom) {
                          return ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    '${localizations.classroom} ${classroom.classroomNumber}'),
                                const Icon(
                                  Icons.arrow_forward,
                                  color: Colors.black,
                                  size: 20,
                                ),
                              ],
                            ),
                            onTap: () {
                              _navigateToMissingFormView(classroom);
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
