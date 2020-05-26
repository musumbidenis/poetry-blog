import 'package:flutter/material.dart';
import 'package:poetry/Pages/main.dart';

class Notify extends StatefulWidget {
  @override
  _NotifyState createState() => _NotifyState();
}

class _NotifyState extends State<Notify> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Notifications',
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
          "No Notifications for now"
        ),
      ),
    );
  }
}