import 'package:computer_status_reporter/src/missing_form/missing_form_view.dart';
import 'package:computer_status_reporter/src/missing_form/select_room_view.dart';
import 'package:computer_status_reporter/src/model/classroom.dart';
import 'package:flutter/material.dart';
import '../model/computer.dart';

class SelectPostView extends StatefulWidget {
  final Classroom selectedClassroom;

  const SelectPostView({Key? key, required this.selectedClassroom})
      : super(key: key);

  @override
  _SelectPostViewState createState() => _SelectPostViewState();
}

class _SelectPostViewState extends State<SelectPostView> {
  List<Computer>? computers = [
    Computer(
        id: 1, computerName: 'Computer 1 ', classroomId: 1, positions: [0, 0]),
    Computer(
        id: 2, computerName: 'Computer 2 ', classroomId: 1, positions: [0, 1]),
    Computer(
        id: 3, computerName: 'Computer 3 ', classroomId: 1, positions: [0, 2]),
    Computer(
        id: 4, computerName: 'Computer 4 ', classroomId: 1, positions: [0, 4]),
    Computer(
        id: 5, computerName: 'Computer 5 ', classroomId: 1, positions: [1, 0]),
    Computer(
        id: 6, computerName: 'Computer 6 ', classroomId: 1, positions: [2, 1]),
    Computer(
        id: 7, computerName: 'Computer 7 ', classroomId: 1, positions: [3, 0]),
    Computer(
        id: 8, computerName: 'Computer 8 ', classroomId: 1, positions: [3, 1]),
    Computer(
        id: 9, computerName: 'Computer 9 ', classroomId: 1, positions: [4, 0]),
    Computer(
        id: 10,
        computerName: 'Computer 10 ',
        classroomId: 1,
        positions: [4, 1]),
    Computer(
        id: 11,
        computerName: 'Computer 11 ',
        classroomId: 1,
        positions: [5, 0]),
    Computer(
        id: 12,
        computerName: 'Computer 12 ',
        classroomId: 1,
        positions: [5, 1]),
    Computer(
        id: 13,
        computerName: 'Computer 13 ',
        classroomId: 1,
        positions: [6, 0]),
    Computer(
        id: 14,
        computerName: 'Computer 14 ',
        classroomId: 1,
        positions: [6, 1]),
  ];

  int maxLine() {
    int max = 0;
    for (var computer in computers!) {
      if (computer.positions[0] > max) {
        max = computer.positions[0];
      }
    }
    return max;
  }

  int maxColumn() {
    int max = 0;
    for (var computer in computers!) {
      if (computer.positions[1] > max) {
        max = computer.positions[1];
      }
    }
    return max;
  }

  void _navigateToPrevious() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SelectRoomView(),
      ),
    );
  }

  void _navigateToMissingFormView(Computer selectedComputer) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MissingFormView(
          selectedClassroom: widget.selectedClassroom,
          selectedComputer: selectedComputer,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Computer'),
      ),
      body: computers == null || computers!.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Aucun PC n\'est recensé dans cette salle.'),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _navigateToPrevious();
                    },
                    child: Text('Revenir en arrière'),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: maxLine() + 1,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Row(
                        children: List.generate(
                          maxColumn() + 1,
                          (index2) {
                            final computer = computers!.firstWhere(
                              (computer) =>
                                  computer.positions[0] == index &&
                                  computer.positions[1] == index2,
                              orElse: () => Computer(
                                id: -1,
                                computerName: '',
                                classroomId: -1,
                                positions: [index, index2],
                              ),
                            );
                            return Expanded(
                              child: InkWell(
                                onTap: computer.id == -1
                                    ? null
                                    : () {
                                        _navigateToMissingFormView(computer);
                                      },
                                child: computer.id == -1
                                    ? Container()
                                    : Card(
                                        color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.computer,
                                                size: 25,
                                                color: Colors.black,
                                              ),
                                              SizedBox(height: 8),
                                              Text(
                                                computer.computerName,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  );
                },
              ),
            ),
    );
  }
}
