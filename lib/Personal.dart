import 'package:abdi/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:abdi/pages/Change_pass.dart';
import 'package:abdi/providers/theme_provider.dart'; // Import the ThemeProvider class

class Personal_information extends StatefulWidget {
  const Personal_information({Key? key}) : super(key: key);

  @override
  State<Personal_information> createState() => _Personal_informationState();
}

class _Personal_informationState extends State<Personal_information> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Personal information"),
        centerTitle: true,
        backgroundColor: Colors.green[100],
      ),
      backgroundColor: Colors.green[100],
      body: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.lock_outline_rounded),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  const Change_password()),
              );
            },
            title: const Text(
              'Change Password',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          Divider(),
          ListTile(
            leading:const  Icon(Icons.wb_sunny_outlined),
            title: const Text(
              'Theme Preference',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),
            ),
            onTap: () {
              // Get the ThemeProvider instance
              var themeProvider = Provider.of<ThemeProvider>(context, listen: false);
              // Toggle theme
              themeProvider.toggleTheme();
            },
          )
        ],
      ),
    );
  }
}
