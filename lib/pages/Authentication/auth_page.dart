import 'package:abdi/Homepage.dart';
import 'package:abdi/Login.dart';
import 'package:abdi/Profile.dart';
import 'package:abdi/Screenpage.dart';
import 'package:abdi/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class auth_page extends StatelessWidget {
  const auth_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
         builder:  (context,snapshot){

          if(snapshot.hasData){
              return const Screenpage();
          }
          else{
              return const  LoginPage();
          }

         }),
    );
  }
}
