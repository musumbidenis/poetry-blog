import 'package:flutter/material.dart';
import 'package:poetry/Pages/main.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Settings',
          style:TextStyle(fontSize:25, color: Colors.black),
        ),
        centerTitle: true,
      leading: GestureDetector(
        onTap: () {
          /*Navigate to the Home page */
          Navigator.push(context, MaterialPageRoute(builder: (context) => Main()));
        },
        child: Icon(
          Icons.arrow_back_ios,
          size: 25.0,
          color: Colors.black,
        ),
       ),
      ),
      body: Center(
        child: Text(
          "Settings"
        ),
      ),
    );
  }
}