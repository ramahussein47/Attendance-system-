import 'package:abdi/pages/Settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:abdi/Personal.dart';

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);
  final user = FirebaseAuth.instance.currentUser;
  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        backgroundColor: Colors.green,
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  height: 120,
                  width: 120,
                  child: GestureDetector(
                    onTap: () {
                      // Show dialog to change profile photo
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Change Profile Photo'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  title: const Text('Take Photo'),
                                  leading: const Icon(Icons.camera_alt),
                                  onTap: () {
                                    // Implement logic to take a photo using camera
                                    Navigator.pop(context); // Close dialog
                                  },
                                ),
                                ListTile(
                                  title: const Text('Choose from Gallery'),
                                  leading: const Icon(Icons.image),
                                  onTap: () {
                                    // Implement logic to choose photo from gallery
                                    Navigator.pop(context); // Close dialog
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: CircleAvatar(

                      backgroundColor: Colors.grey[200],
                      child: Icon(
                        Icons.person,
                        size: 80,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const SizedBox(height: 4),
                Text(
                  'Email:' + user!.email!,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.black.withOpacity(0.2),
            height: 0,
            thickness: 1,
            indent: 16,
            endIndent: 16,
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Personal Information'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Personal_information()),
              );
            },
          ),
          Divider(
            color: Colors.black.withOpacity(0.2),
            height: 0,
            thickness: 1,
            indent: 16,
            endIndent: 16,
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()));
            },
          ),
          Divider(
            color: Colors.black.withOpacity(0.2),
            height: 0,
            thickness: 1,
            indent: 16,
            endIndent: 16,
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Log Out?'),
                    content: const Text('Are you sure you want to log out?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('NO'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          signOut();
                        },
                        child: const Text('Yes'),
                      )
                    ],
                  );
                },
              );
            },
          ),
          Divider(
            color: Colors.black.withOpacity(0.2),
            height: 0,
            thickness: 1,
            indent: 16,
            endIndent: 16,
          ),
        ],
      ),
    );
  }
}
