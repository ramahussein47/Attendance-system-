import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddUnits extends StatefulWidget {
  const AddUnits({Key? key}) : super(key: key);

  @override
  State<AddUnits> createState() => _AddUnitsState();
}

class _AddUnitsState extends State<AddUnits> {
  final TextEditingController _studentIdController = TextEditingController();
  String? _selectedUnit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        title: const Text('Enroll Units'),
        centerTitle: true,
        backgroundColor: Colors.green[100],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showEnrollDialog();
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              'Selected Unit: ${_selectedUnit ?? "None"}',
              style:const  TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: _buildEnrolledStudentsList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEnrolledStudentsList() {
    if (_selectedUnit == null) {
      return const SizedBox.shrink();
    }

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('units')
          .doc(_selectedUnit)
          .collection('students')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        List<Widget> studentWidgets = [];
        snapshot.data!.docs.forEach((doc) {
          String studentName = doc['name'];
          String studentId = doc['id'];
          studentWidgets.add(ListTile(
            title: Text(studentName),
            subtitle: Text(studentId),
          ));
        });

        return ListView(
          children: studentWidgets,
        );
      },
    );
  }

  void _showEnrollDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('units').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }

            List<DropdownMenuItem<String>> items = [];
            snapshot.data!.docs.forEach((doc) {
              String unitName = doc['name'];

              items.add(DropdownMenuItem(child: Text(unitName), value: unitName));
            });

            return AlertDialog(
              title: Text("Enroll User"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<String>(
                    value: _selectedUnit,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedUnit = newValue;
                      });
                    },
                    items: items,
                    decoration: InputDecoration(
                      labelText: 'Select Unit',
                    ),
                  ),
                  TextField(
                    controller: _studentIdController,
                    decoration: InputDecoration(labelText: 'Student ID'),
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    _enrollUser();
                    Navigator.of(context).pop();
                  },
                  child: const Text('Enroll'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _enrollUser() {
    if (_selectedUnit == null) {
      return;
    }

    String studentId = _studentIdController.text;
    String selectedUnit = _selectedUnit!;

    // Store enrolled student in Firestore
    FirebaseFirestore.instance
        .collection('units')
        .doc(selectedUnit)
        .collection('students')
        .add({
      'id': studentId,
      'name': 'Student Name',
    }).then((_) {
      // Clear text field after enrollment
      _studentIdController.clear();
    }).catchError((error) {
      print('Failed to enroll student: $error');
    });
  }
}
