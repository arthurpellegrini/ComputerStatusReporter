import 'package:computer_status_reporter/src/missing_form/missing_form_view.dart';
import 'package:computer_status_reporter/src/missing_form/select_room_view.dart';
import 'package:computer_status_reporter/src/model/classroom.dart';
import 'package:computer_status_reporter/src/model/dataController.dart';
import 'package:flutter/material.dart';
import '../model/computer.dart';

class SelectPostView extends StatefulWidget {
  final Classroom selectedClassroom;
  final DataController dataController;

  const SelectPostView({Key? key, required this.dataController, required this.selectedClassroom})
      : super(key: key);

  @override
  _SelectPostViewState createState() => _SelectPostViewState();
}

class _SelectPostViewState extends State<SelectPostView> {
  List<Computer>? computers;

  @override
  void initState() {
    super.initState();
    createComputersList();
  }

  void createComputersList() {
    setState(() {
      computers = widget.dataController.getComputersByClassroom(widget.selectedClassroom.id);
    });
  }

  int maxLine() {
    int max = 0;
    for (var computer in computers!) {
      if (computer.positions[0] > max) {
        max = computer.positions[0];
      }
    }
    return max;
  }

  void _navigateToPrevious() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SelectRoomView(dataController: widget.dataController),
      ),
    );
  }

  void _navigateToMissingFormView(Computer selectedComputer) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MissingFormView(
          dataController: widget.dataController,
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
                    onPressed: _navigateToPrevious,
                    child: Text('Revenir en arrière'),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: maxLine() + 1,
                itemBuilder: (context, rowIndex) {
                  return Column(
                    children: [
                      Row(
                        children: List.generate(5, (colIndex) {
                          if (colIndex == 2) {
                            return Expanded(child: Container());
                          }

                          final int computerColIndex = colIndex > 2 ? colIndex - 1 : colIndex;

                          final computer = computers!.firstWhere(
                            (computer) =>
                                computer.positions[0] == rowIndex &&
                                computer.positions[1] == computerColIndex,
                            orElse: () => Computer(
                              id: "-1",
                              computerName: '',
                              classroomId: "-1",
                              positions: [rowIndex, computerColIndex],
                            ),
                          );

                          return Expanded(
                            child: InkWell(
                              onTap: computer.id == "-1"
                                  ? null
                                  : () {
                                      _navigateToMissingFormView(computer);
                                    },
                              child: Card(
                                color: computer.id == "-1" ? Colors.transparent : Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.computer,
                                        size: 25,
                                        color: computer.id == "-1" ? Colors.transparent : Colors.black,
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
                        }),
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
