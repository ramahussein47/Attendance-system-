import 'package:abdi/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();



Future<void> signup(BuildContext context) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _userController.text.trim(),
      password: _passwordController.text.trim(),
    );


    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('User created successfully'),
        backgroundColor: Colors.blue,
        duration: Duration(seconds: 3),
      ),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error: ${e.toString()}'),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             const  Icon(
                Icons.android,
                size: 120,
                color: Colors.blue,
              ),
              const Text(
                'Register An Account',
                style: TextStyle(
                  fontSize: 34,
                  fontStyle: FontStyle.normal,
                  color: Colors.blue,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.2),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(),

                  ),
                  child: TextFormField(
                    controller: _userController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your Username';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Email',
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.2),
                    borderRadius: BorderRadius.circular(10),

                  ),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your Password';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Password',
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size>(const Size(380, 50)),
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(16)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                onPressed: () {
                  // Validate the form
                  if (_userController.text.isNotEmpty &&
                      _passwordController.text.isNotEmpty) {
                    // Perform registration logic
                    signup(context);
                    print('Registration successful');
                  } else {
                    // Show error message if form is not valid
                    ScaffoldMessenger.of(context).showSnackBar(
                     const  SnackBar(
                        content: Text('Please fill the form correctly.'),
                        duration: Duration(seconds: 3),
                      ),
                    );
                  }
                },
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

