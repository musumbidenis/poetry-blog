import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  File selectedImage;


  /*Get the image from gallery */
  Future getImage() async{
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    
    setState(() {
      selectedImage = image;
    });
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 45.0, vertical: 60.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                  child: Text("Sign Up",
                    style: TextStyle(
                      fontSize: 45.0,
                      fontFamily: 'Pacifico',
                    ),
                  ),
              ),
              SizedBox(height: 30.0),
              Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'USERNAME',
                      labelStyle: TextStyle(
                          fontFamily: 'Source Sans Pro',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)
                      )
                    ),
                  ),
                  SizedBox(height: 8.0),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'PASSWORD',
                      labelStyle: TextStyle(
                          fontFamily: 'Source Sans Pro',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)
                      )
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 8.0),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'EMAIL',
                      labelStyle: TextStyle(
                          fontFamily: 'Source Sans Pro',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)
                      )
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 8.0),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'PHONE',
                      labelStyle: TextStyle(
                          fontFamily: 'Source Sans Pro',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)
                      )
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 40.0),
                  Container(
                    height: 50.0,
                    child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      shadowColor: Colors.redAccent,
                      color: Colors.red,
                      elevation: 5.0,
                      child: GestureDetector(
                        onTap: () {},
                        child: Center(
                          child: Text(
                            'REGISTER',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Source Sans Pro'
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Already have an account ?',
                  ),
                  SizedBox(width: 5.0),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}