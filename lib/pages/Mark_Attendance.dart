import 'package:abdi/pages/mark.dart';
import 'package:flutter/material.dart';
import 'package:abdi/ser/Cloud_database.dart';

class MarkAttendancepage extends StatefulWidget {
  const MarkAttendancepage({Key? key}) : super(key: key);

  @override
  State<MarkAttendancepage> createState() => _MarkAttendancepageState();
}

class _MarkAttendancepageState extends State<MarkAttendancepage> {
  final FireStoreService fireStoreService = FireStoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green[100],
        title: const Text(
          'Mark Attendance',
          style: TextStyle(fontSize: 15),
        ),
      ),
      body: FutureBuilder<List<String>>(
        future: fireStoreService.getClasses()
        , // Call the method to fetch classes
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const  Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const  Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.book,
                    size: 100,
                    color: Colors.grey,
                  ),
                  Text(
                    'No classes added',
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                ],
              ),
            );
          } else {
            List<String> lecturerClasses = snapshot.data!; // Extract classes from snapshot
            return ListView.builder(
              itemCount: lecturerClasses.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(lecturerClasses[index]),

                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AttendanceMarkingPage(
                          className: lecturerClasses[index],

                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
