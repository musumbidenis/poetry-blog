import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Profile',
          style:TextStyle(fontSize:25, color: Colors.black),
        ),
        centerTitle: true,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
          child: Icon(
          Icons.arrow_back_ios,
          size: 25.0,
          color: Colors.black,
        ),
       ),
      ),
      body: Column(
        children: <Widget>[
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('https://placeimg.com/640/480/any'),
          ),
          Text("Denis Nzamba",
          style: TextStyle(
            fontSize: 30.0,
            fontFamily: 'Pacifico',
            letterSpacing: 2.5,
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
            ),
          ),
          Card(
            elevation: 10.0,
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
            child: ListTile(
              leading: Icon(
                Icons.phone,
                color: Colors.grey[700],
              ),
              title: Text("+254 713 710 887",
                style: TextStyle(
                  color: Colors.grey[700],
                  fontFamily: 'Source Sans Pro',
                  fontSize: 17.0,
                ),
              ),
            ),
          ),
          Card(
            elevation: 10.0,
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
            child: ListTile(
              leading: Icon(
                Icons.mail,
                color: Colors.grey[700],
              ),
              title: Text("musumbidenis@gmail.com",
                style: TextStyle(
                  color: Colors.grey[700],
                  fontFamily: 'Source Sans Pro',
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ]
      )
    );
  }
}
