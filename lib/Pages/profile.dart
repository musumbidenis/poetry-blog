import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:poetry/Models/api.dart';
import 'package:poetry/Models/userInfo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  @override
  void initState(){
    super.initState();
    getUserInfo();
  }

  /*Fetch the posts */
  Future<List<UserInfo>> getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var username = localStorage.getString('userKey');

    var data = {
      "username": username,
    };
    
    var response = await CallAPi().postData(data,'userInfo');
    var jsonData = json.decode(response.body);

    /*Create a list array to store the fetched data*/
    List<UserInfo> details = [];

    /*Loop through the jsonData and add the items to the list array created*/
    for (var u in jsonData) {
      UserInfo detail = UserInfo(
        u["username"],
        u["email"],
        u["phone"],
        u["avatarUrl"],
      );

      details.add(detail);
    }

    return details;
  
  }


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
      body: FutureBuilder(
        future: getUserInfo(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context, int index){
          return Column(
            children: <Widget>[
              CircleAvatar(
                radius: 60,
                backgroundImage: snapshot.data[index].avatarUrl != null ?
                NetworkImage(snapshot.data[index].avatarUrl) :
                NetworkImage('http://poetry.musumbidenis.co.ke/storage/app/default.jpg'),
              ),
              Text("@" "${snapshot.data[index].username}",
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
                  title: Text(snapshot.data[index].phone,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontFamily: 'Source Sans Pro',
                      fontSize: 17.0,
                    ),
                  ),
                  trailing: InkWell(
                    child: Icon(
                      Icons.edit,
                    ),
                    onTap: (){},
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
                  title: Text(snapshot.data[index].email,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontFamily: 'Source Sans Pro',
                      fontSize: 15.0,
                    ),
                  ),
                  trailing: InkWell(
                    child: Icon(
                      Icons.edit,
                    ),
                    onTap: (){},
                  ),
                ),
              ),
            ]
          );
        });
       } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
       }
        /*By default, show a loading spinner */
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
              SizedBox(height: 8.0),
              Text("Loading..")
            ],
          ),
        );
       }
      )
    );
  }
}
