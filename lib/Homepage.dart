import 'package:abdi/ser/Cloud_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final FireStoreService fireStoreService = FireStoreService();
  final TextEditingController classController = TextEditingController();
  TimeOfDay _selectedTime = TimeOfDay(hour: 0, minute: 0);

  void _showAddClassDialog(String? DocId) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: classController,
              decoration: const InputDecoration(labelText: 'Class Name'),
            ),
          const   SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              const   Text(
                  'Selected Time:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                 Text('${_selectedTime.format(context)}'),
              ],
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              // updating the classes
              if (DocId == null) {
                fireStoreService.addClass(
                  classController.text,
                  _selectedTime.format(context),
                );
              } else {
                fireStoreService.updateClass(
                  classController.text,
                  DocId,
                  _selectedTime.format(context), // Use _selectedTime for format
                );
              }
              classController.clear();
              // Close the dialog
              Navigator.pop(context);
            },
            child: const Text('Confirm'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const  Text('Cancel'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 180, 199, 179),
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverAppBar(
            title: Text(
              'Attendance System',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            backgroundColor: Colors.green,
            centerTitle: true,
            pinned: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25),
              ),
            ),
          ),
          // StreamBuilder to display classes or show no classes added
          StreamBuilder<QuerySnapshot>(
            stream: fireStoreService.classesCollection.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (snapshot.hasError) {
                return SliverFillRemaining(
                  child: Center(
                    child: Text('Error: ${snapshot.error}'),
                  ),
                );
              }
              final classes = snapshot.data!.docs;
              if (classes.isEmpty) {
                return const  SliverFillRemaining(
                  child: Center(
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
                  ),
                );
              }
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final className = classes[index]['className'];
                    final timestamp =
                        (classes[index]['timestamp'] as Timestamp).toDate();
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 6,
                        shadowColor: Colors.grey,
                        child: ListTile(
                          title: Text(
                            className,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.settings),
                          ),
                          subtitle: Text(
                            'Created on: ${timestamp.toString()}',
                          ),
                          // Add any other properties you want to display
                        ),
                      ),
                    );
                  },
                  childCount: classes.length,
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddClassDialog(null), // Pass null for DocId
        child: const Icon(Icons.add),
      ),
    );
  }
}
