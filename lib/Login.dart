import 'package:abdi/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // function for sign in
     void signin() async {
      // circular progress indicator
        showDialog(context: context, builder: (context){
            return const Center(
               child: CircularProgressIndicator(),
            );
        });
    // Check if both email and password fields are not empty
    if (_username.text.isNotEmpty && _password.text.isNotEmpty) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _username.text,
          password: _password.text,
        );
      }  on FirebaseAuthException  catch  (e) {


       if (e.code== 'user-not-found'){
          // Handle sign-in errors (e.g., display error message)
        ScaffoldMessenger.of(context).showSnackBar(
         const  SnackBar(
            content: Text('Wrong Email.'),
          ),
        );

       }
else if  (e.code=='wrong-password'){
         // Handle sign-in errors (e.g., display error message)
        ScaffoldMessenger.of(context).showSnackBar(
         const  SnackBar(
            content: Text('Wrong password'),
          ),
        );
}

      }
    } else {
      // Display error message if email or password field is empty
      ScaffoldMessenger.of(context).showSnackBar(
      const   SnackBar(
          content: Text('Please enter both email and password.'),
        ),
      );
    } // pop the cirlce
    Navigator.pop(context);
  }
  final _username=TextEditingController();
  final _password=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
         body: SafeArea(
           child: Column(


            mainAxisAlignment: MainAxisAlignment.center,
               children: [
              const   Icon(
                  Icons.android,
                  size: 120,
                  color: Colors.green,

                ),

                          Text('Easy Attendance System ',
                          style: TextStyle(
                            fontSize: 30,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,


                            color: Colors.green[400],


                          ),),
                         const  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(.2),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(),
                      ),
                      child: TextFormField(
                        controller: _username,
                        validator: (value){
                            if(value!.isEmpty){
                                print('Please Enter your Username');
                            }
                            return null;
                        },
                        decoration: InputDecoration(

                             hintText: 'Email',
                             border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                             ),


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
                        border: Border.all(),
                      ),
                      child: TextFormField(
                        obscureText: true,
                        controller: _password,
                        validator: (value){
                            if(value!.isEmpty){
                                 print('Please enter your Username');
                            }
                            return null;
                        },
                        decoration: InputDecoration(


                             hintText: 'Password',
                             border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                             )

                        ),
                      ),


                    ),
                  ),
                 const SizedBox(height: 10,),
                  Container(
                    decoration: const BoxDecoration(

                    ),

            child: ElevatedButton(
             style: ButtonStyle(
               minimumSize: MaterialStateProperty.all<Size>(const Size(380,30 )),
               backgroundColor: MaterialStateProperty.all<Color>(Colors.green), // Background color
               foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Text color
               padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(16)), // Padding
               shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                 RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(8.0),

                 ),
               ),
               elevation: MaterialStateProperty.all<double>(5), // Elevation (shadow)
             ),
              onPressed: signin,
             child: const Text('Login',style: TextStyle(
               fontSize: 20,
             ),), // Button text
           ),

                  ),
                const   SizedBox(height: 4,),
                 Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                  TextButton(onPressed: (){



                  }, child:const  Text("Forgot Password?")),
                          TextButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> const Signup()));

                          }, child: const Text('Dont have an account?',
                          style: TextStyle(
                            color: Colors.blue,
                              fontStyle: FontStyle.italic,
                          ),),)

                    ],

                    )

               ],

           ),
         ),
    );
  }
}
