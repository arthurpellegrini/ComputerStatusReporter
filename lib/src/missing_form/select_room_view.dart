import 'package:computer_status_reporter/src/missing_form/select_post_view.dart';
import 'package:computer_status_reporter/src/model/data_controller.dart';
import 'package:flutter/material.dart';
import 'package:computer_status_reporter/src/model/classroom.dart';


class SelectRoomView extends StatefulWidget {

  
  final DataController dataController;

  const SelectRoomView({super.key, required this.dataController});
  
  @override
  _SelectRoomViewState createState() => _SelectRoomViewState();
}

class _SelectRoomViewState extends State<SelectRoomView> {
  Map<int, List<Classroom>> classroomsByFloor = {};

  // Initial state for expansion panels
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
      classroomsByFloor.keys.forEach((key) {
        _isExpanded[key] = false;
      });
    });
  }

  void _navigateToMissingFormView(Classroom selectedClassroom) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            SelectPostView(dataController: widget.dataController, selectedClassroom: selectedClassroom),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Classroom'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            const Text('Select a Classroom'),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: classroomsByFloor.keys.length,
                itemBuilder: (context, index) {
                  int floor = classroomsByFloor.keys.elementAt(index);
                  return ExpansionTile(
                    title: Text('Floor $floor'),
                                  onExpansionChanged: (isExpanded) {
                      setState(() {
                        _isExpanded[floor] = isExpanded;
                      });
                    },
                    initiallyExpanded: _isExpanded[floor]!,
                    children: classroomsByFloor[floor]!.map((classroom) {
                      return ListTile(
                        title: Text('Classroom ${classroom.classroomNumber}'),
                        onTap: () {
                          _navigateToMissingFormView(classroom);
                        },
                      );
                    }).toList(),
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
