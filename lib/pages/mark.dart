import 'package:abdi/ser/Cloud_database.dart';
import 'package:flutter/material.dart';

class AttendanceMarkingPage extends StatefulWidget {
  final String className;

  const AttendanceMarkingPage({Key? key, required this.className})
      : super(key: key);

  @override
  State<AttendanceMarkingPage> createState() => _AttendanceMarkingPageState();
}

class _AttendanceMarkingPageState extends State<AttendanceMarkingPage> {
  final FireStoreService fireStoreService = FireStoreService();
  late List<bool> isPresent; // Declare isPresent as late

  @override
  void initState() {
    super.initState();
    // Initialize isPresent list with false values

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.className),
      ),
      body: FutureBuilder<List<String>>(
        future: fireStoreService.getClasses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error with connection',
                style: TextStyle(color: Colors.red),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.question_mark,
                    size: 100,
                    color: Colors.grey,
                  ),
                  Text(
                    'No student enrolled',
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                ],
              ),
            );
          } else {
            List<String> enrolledStudents = snapshot.data!;
            return ListView.builder(
              itemCount: enrolledStudents.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(enrolledStudents[index]),
                  trailing: Checkbox(
                    value: isPresent[index],
                    onChanged: (value) {
                      setState(() {
                        isPresent[index] = value ?? false;
                      });
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
