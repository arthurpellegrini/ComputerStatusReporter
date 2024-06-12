import 'package:computer_status_reporter/src/missing_form/select_post_view.dart';
import 'package:flutter/material.dart';
import '../model/classroom.dart';

class SelectRoomView extends StatefulWidget {
  @override
  _SelectRoomViewState createState() => _SelectRoomViewState();
}

class _SelectRoomViewState extends State<SelectRoomView> {
  Map<int, List<Classroom>> classroomsByFloor = {
    3: [
      Classroom(id: 'sdnfjsdf', classroomNumber: 8, floor: 3),
      Classroom(id: 'bnmbnm', classroomNumber: 30, floor: 3),
      Classroom(id: 'lkjlkj', classroomNumber: 35, floor: 3),
    ],
    2: [
      Classroom(id: 'azsdaze', classroomNumber: 12, floor: 2),
      Classroom(id: 'xcvxcv', classroomNumber: 25, floor: 2),
    ],
    1: [
      Classroom(id: 'qweqwe', classroomNumber: 15, floor: 1),
      Classroom(id: 'yuiyui', classroomNumber: 20, floor: 1),
    ],
  };

  // Initial state for expansion panels
  Map<int, bool> _isExpanded = {};

  @override
  void initState() {
    super.initState();
    // Initialize the expansion state for each floor
    classroomsByFloor.keys.forEach((key) {
      _isExpanded[key] = false;
    });
  }

  void _navigateToMissingFormView(Classroom selectedClassroom) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            SelectPostView(selectedClassroom: selectedClassroom),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Classroom'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text('Select a Classroom'),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: classroomsByFloor.keys.length,
                itemBuilder: (context, index) {
                  int floor = classroomsByFloor.keys.elementAt(index);
                  return ExpansionTile(
                    title: Text('Floor $floor'),
                    children: classroomsByFloor[floor]!.map((classroom) {
                      return ListTile(
                        title: Text('Classroom ${classroom.classroomNumber}'),
                        onTap: () {
                          _navigateToMissingFormView(classroom);
                        },
                      );
                    }).toList(),
                    onExpansionChanged: (isExpanded) {
                      setState(() {
                        _isExpanded[floor] = isExpanded;
                      });
                    },
                    initiallyExpanded: _isExpanded[floor]!,
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
