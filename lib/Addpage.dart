import 'package:abdi/pages/Add_units.dart';

import 'package:abdi/pages/Mark_Attendance.dart';
import 'package:flutter/material.dart';

class Addpage extends StatefulWidget {
  const Addpage({Key? key}) : super(key: key);

  @override
  State<Addpage> createState() => _AddpageState();
}

class _AddpageState extends State<Addpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(25),
          bottomLeft: Radius.circular(25),
        )),
        backgroundColor: Colors.green,
        centerTitle: true,
        title: const Text(
          'Add/View Page',
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              // Navigate to Add Units page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>AddUnits()),
              );
            },
            child:const  Center(
              child: SizedBox(
                height: 150,
                width: 500,
                child: Padding(
                  padding:  EdgeInsets.all(8.0),
                  child: Card(
                    shadowColor: Colors.grey,
                    elevation: 4.0,
                    color: Colors.green,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add),
                        Text(
                          'Enroll Units',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              // Navigate to Mark Attendance page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MarkAttendancepage()),
              );
            },
            child: const SizedBox(
              height: 150,
              width: 500,
              child: Padding(
                padding:  EdgeInsets.all(8.0),
                child: Card(
                  color: Color.fromARGB(255, 2, 150, 219),
                  shadowColor: Colors.grey,
                  elevation: 4.0,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.menu_book_rounded),
                        Text(
                          'Mark Attendance ',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
