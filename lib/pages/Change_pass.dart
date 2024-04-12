import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Change_password extends StatefulWidget {
  const Change_password({super.key});

  @override
  State<Change_password> createState() => _Change_passwordState();
}

class _Change_passwordState extends State<Change_password> {
  final _password1 = TextEditingController();
  final _password2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        const   Text(
            'Change Password',
            style: TextStyle(
              fontSize: 34,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                obscureText: false,
                controller: _password1,
                decoration: InputDecoration(
                  labelText: 'Current password',
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              obscureText: false,
              controller: _password2,
              decoration:const  InputDecoration(
                labelText: 'Re-enter password',
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Check if the password fields are empty
              if (_password1.text.isEmpty || _password2.text.isEmpty) {
                // Show red Snackbar if the password fields are empty
                final snackBar = SnackBar(
                  content: Text(
                    'Please enter both passwords',
                    style: TextStyle(color: Colors.black),
                  ),
                  duration: Duration(seconds: 3),
                  backgroundColor: Colors.red,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } else {
                // Show success Snackbar if passwords are entered
                final snackBar =  SnackBar(
                  content: Text('Password Changed'),
                  duration: Duration(seconds: 3),
                  backgroundColor: Colors.green,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue,
              elevation: 4,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }
}
