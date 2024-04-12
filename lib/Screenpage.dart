import 'package:abdi/Addpage.dart';
import 'package:abdi/Homepage.dart';
import 'package:abdi/Profile.dart';
import 'package:flutter/material.dart';

class Screenpage extends StatefulWidget {
  const Screenpage({Key? key}) : super(key: key);

  @override
  State<Screenpage> createState() => _ScreenpageState();
}

class _ScreenpageState extends State<Screenpage> {
  int current_page = 0;
  final List<Widget> _pages = [
     Homepage(),
    Addpage(),
     Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[current_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: current_page,
        selectedItemColor: Colors.white,
        backgroundColor: Colors.green,
        onTap: (index) {
          print('this is the selected index $index');
          setState(() {
            current_page = index;
          });
        },
        items:const  [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
