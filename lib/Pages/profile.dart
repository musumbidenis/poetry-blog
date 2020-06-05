import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:poetry/Models/api.dart';
import 'package:poetry/Models/post.dart';
import 'package:poetry/Models/userInfo.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:poetry/Pages/main.dart';
import 'package:poetry/Pages/postData.dart';
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
    getUserPosts();
  }

  /*Fetch the user info */
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

  /*Fetch the posts of the user */
  Future<List> getUserPosts() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var username = localStorage.getString('userKey');

    var data = {
      "username": username,
    };
    
    var response = await CallAPi().postData(data,'userPosts');
    var jsonData = json.decode(response.body);
print(jsonData);
    /*Create a list array to store the fetched data*/
    List<Post> userPosts = [];

    /*Loop through the jsonData and add the items to the list array created*/
    for (var uP in jsonData) {
      Post userPost = Post(
        uP["postId"],
        uP["title"],
        uP["description"],
        uP["imageUrl"],
        uP["username"],
        uP["created_at"],
      );

      userPosts.add(userPost);
      
    }
    
    return userPosts;
  
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
      body: ListView(
          children: <Widget>[
            Container(
            height: MediaQuery.of(context).size.height * .50,
            child: FutureBuilder(
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
                      backgroundImage: snapshot.data[index].avatarUrl == null ?
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
                return Center(
                  child: Column(
                    children: <Widget>[
                      Icon(
                        Icons.signal_wifi_off,
                        color: Colors.red,
                        size: 150.0,
                      ),
                      Text('Check your internet connection \nand try again!',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontFamily: 'Source Sans Pro'
                        ),
                      ),
                    ],
                  ),
                );
              }/*By default, show a loading spinner */
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
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical:10.0, horizontal: 30.0),
            child: Text("My Posts",
              style: TextStyle(
                fontSize:25,
                fontFamily: 'Source Sans Pro',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Divider(
            color: Colors.black,
            height: 10,
            indent: 30,
            endIndent: 30,
          ),
          FutureBuilder(
            future: getUserPosts(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return  ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    // var initial = snapshot.data[index].username;
                    /*Get the timestamp */
                    var date = DateTime.parse(snapshot.data[index].created_at);
                    /*Find the difference in time from now in seconds */
                    var difference = DateTime.now().difference(date).inSeconds;
                    
                    /*Format it into time ago */
                    var timeAgo = DateTime.now().subtract(Duration(seconds: difference));
                    var timestamp = (timeago.format(timeAgo));

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.29,
                        child: Card(
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) => PostData(
                                  title:"${snapshot.data[index].title}",
                                  description: "${snapshot.data[index].description}",
                                  imageUrl: "${snapshot.data[index].imageUrl}",
                                  username: "${snapshot.data[index].username}",
                                  timestamp: "$timestamp",
                                ),
                              ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              image: DecorationImage(
                                image: NetworkImage(snapshot.data[index].imageUrl),
                                fit: BoxFit.fill,
                                colorFilter: new ColorFilter.mode(
                                  Colors.black.withOpacity(1.0),
                                  BlendMode.softLight,
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                  child: Text(
                                    snapshot.data[index].title,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontFamily: 'Source Sans Pro',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                              ),
                            ),
                          ),
                        ),
                      ),
                     ),
                    );
                  }
                );
              } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
              } /*By default, show a loading spinner */
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    SizedBox(height: 8.0),
                    Text("Loading posts..")
                  ],
                ),
              );  
            }
          ),
        ],
      ),
    );
  }
}
