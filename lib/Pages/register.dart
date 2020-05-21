import 'dart:convert';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:poetry/Models/api.dart';
import 'package:poetry/Pages/login.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _isLoading = false;

  GlobalKey<FormState> _formKey = GlobalKey();

  /*Text Controllers */
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();


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
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: username,
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
                      keyboardType: TextInputType.text,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Username field cannot be blank";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 8.0),
                    TextFormField(
                      controller: password,
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
                      keyboardType: TextInputType.text,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Password field cannot be blank";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 8.0),
                    TextFormField(
                      controller: email,
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
                      keyboardType: TextInputType.emailAddress,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Email field cannot be blank";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 8.0),
                    TextFormField(
                      controller: phone,
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
                      keyboardType: TextInputType.phone,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Phone field cannot be blank";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 40.0),
                    Container(
                      height: 50.0,
                      child: GestureDetector(
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          shadowColor: Colors.redAccent,
                          color: Colors.red,
                          elevation: 5.0,
                          child: GestureDetector(
                            child: Center(
                              child: Text( _isLoading ? 'REGISTERING..' :
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
                        onTap: handleRegister,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Already have an account ?',
                  ),
                  SizedBox(width: 5.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,MaterialPageRoute(builder: (context) => Login()));
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline
                      ),
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

  Future<void> handleRegister() async {
    var form = _formKey.currentState;
    if (form.validate()){
      form.save();

      /*User data to be pushed to db */
      var data = {
        "username": username.text,
        "password": password.text,
        "email": email.text,
        "phone": phone.text,
      };

      /*Set the registration button to loading state */
      setState(() {
        _isLoading = true;
      });

      /*Handles posting data to db */
      var response = await CallAPi().postData(data, 'register');
      var body = json.decode(response.body);

      if(body == 'success'){
        /*Navigate to login page */
        Navigator.pop(context);

        /**Set loading state of button to false &&
         * Clear the text fields
        */
        username.clear();
        password.clear();
        email.clear();
        phone.clear();
        setState(() {
          _isLoading = false;
        });

        /**Display success message */
        Flushbar(
          message:  "Registration was successfull!",
          duration:  Duration(seconds: 10),  
          backgroundColor: Colors.green,            
        )..show(context);

      }else if(body == 'userExists'){
        /**Display error message */
        Flushbar(
          message:  "Username already taken! Please choose a unique username.",
          duration:  Duration(seconds: 10),  
          backgroundColor: Colors.red,            
        )..show(context);

        /**Set loading state of button to false &&
         * Clear the username text field
        */
        username.clear();
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}