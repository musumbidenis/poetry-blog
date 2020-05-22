import 'package:flutter/material.dart';
import 'package:poetry/Pages/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Pages/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget { 
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedIn = false;

  @override
  void initState(){
    _checkIfLoggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(color: Colors.white),
        primarySwatch: Colors.blue,
      ),
      home: _isLoggedIn ? Main() : Login(),
    );
  }

  void _checkIfLoggedIn() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = localStorage.getString('userKey');

    /*If !=null remain logged in */
    if(user!=null){
      _isLoggedIn = true;
    }
  }
}

