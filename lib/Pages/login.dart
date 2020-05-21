import 'dart:convert';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:poetry/Models/api.dart';
import 'package:poetry/Pages/main.dart';
import 'package:poetry/Pages/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isLoading = false;

  GlobalKey<FormState> _formKey = GlobalKey();

  /*Text Controllers */
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 45.0, vertical: 150.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                    child: Text("Sign In",
                      style: TextStyle(
                        fontSize: 45.0,
                        fontFamily: 'Pacifico',
                      ),
                    ),
                ),
                SizedBox(height: 10.0),
                Column(
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
                    Container(
                      alignment: Alignment(1.0, 0.0),
                      padding: EdgeInsets.only(top: 15.0, left: 20.0),
                      child: InkWell(
                        child: Text(
                          'Forgot Password ?',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      height: 50.0,
                      child: GestureDetector(
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          shadowColor: Colors.redAccent,
                          color: Colors.red,
                          elevation: 5.0,
                            child: Center(
                              child: Text( _isLoading ? 'LOGING..' :
                                'LOGIN',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Source Sans Pro'
                                ),
                              ),
                            ),
                        ),
                        onTap: handleLogin,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Dont have an account?",
                      style: TextStyle(color: Colors.black54),
                    ),
                    SizedBox(width: 10.0),
                    GestureDetector(
                      child: Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline
                        ),
                      ),
                      onTap: () {
                        Navigator.push(context,MaterialPageRoute(builder: (context) => Register()));
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Future<void> handleLogin() async {
    var form = _formKey.currentState;
    if (form.validate()){
      form.save();

      /*User data to be pushed to db */
      var data = {
        "username": username.text,
        "password": password.text,
      };

      /*Set the login button to loading state */
      setState(() {
        _isLoading = true;
      });

      /*Handles posting data to db */
      var response = await CallAPi().postData(data, 'login');
      var body = json.decode(response.body);

      if(body == 'success'){
        /*Navigate to the Home page */
        Navigator.push(context, MaterialPageRoute(builder: (context) => Main()));

        /*Save the username of logged in user to localstorage */
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.setString('userKey', username.text);
    

        /**Set loading state of button to false &&
         * Clear the text fields
         */
        username.clear();
        password.clear();
        setState(() {
          _isLoading = false;
        });

      }else{
        /**Display error message */
        Flushbar(
          message:  "Incorrect details! Please try again.",
          duration:  Duration(seconds: 3),  
          backgroundColor: Colors.red,            
        )..show(context);

        /**Set loading state of button to false &&
         * Clear the text fields
         */
        username.clear();
        password.clear();
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}