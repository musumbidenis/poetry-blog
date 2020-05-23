import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:poetry/Models/api.dart';
import 'package:poetry/Pages/postData.dart';
import 'package:poetry/Models/post.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState(){
    super.initState();
    getPosts();
  }

  /*Fetch the posts */
  Future<List<Post>> getPosts() async {
    var response = await CallAPi().getData('posts');
    var jsonData = json.decode(response.body);

    /*Create a list array to store the fetched data*/
    List<Post> posts= [];

    /*Loop through the jsonData and add the items to the list array created*/
    for (var p in jsonData) {
      Post post = Post(
        p["title"],
        p["description"],
        p["imageUrl"],
        p["username"],
        p["created_at"],
      );

      posts.add(post);
    }

    return posts;
  
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Poetry',
          style:TextStyle(
            color: Colors.black,
            fontSize:27, 
            fontFamily: 'Pacifico',
          ),
        ),
        centerTitle: true,
      leading: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
          child: Icon(
          Icons.menu,
          size: 30.0,
          color: Colors.black,
        ),
       ),
       actions: <Widget>[
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: CircleAvatar(
             radius: 15.0,
           ),
         ),
       ],
      ),
      body: RefreshIndicator(
        onRefresh: getPosts,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left:20.0),
              child: Text("Popular",
                style: TextStyle(
                  fontSize:25,
                  fontFamily: 'Source Sans Pro',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * .30,
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
              child: FutureBuilder(
                future: getPosts(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal:10.0),
                        child: Center(
                          child: Text(
                            "No connection.Check your internet connection",
                            style: TextStyle(
                            color: Color(0xffe6020a),
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    break;
                    case ConnectionState.active:
                    case ConnectionState.waiting:
                      return Container(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              CircularProgressIndicator(),
                              SizedBox(height: 10.0,),
                              Text(
                                "Loading posts",
                              )
                            ],
                          ),
                        ),
                      );
                    break;
                    case ConnectionState.done:
                      if (snapshot.hasError) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal:10.0),
                          child: Center(
                            child: Text(
                              "Some problem occurred.Check your internet connection and try again!",
                              style: TextStyle(
                              color: Color(0xffe6020a),
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
                    } else if (snapshot.hasData) {
                    return  ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index){
                        return Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Card(
                            child: GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => PostData(
                                    title:"${snapshot.data[index].title}",
                                    description: "${snapshot.data[index].description}",
                                    imageUrl: "${snapshot.data[index].imageUrl}",
                                    username: "${snapshot.data[index].username}",
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
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Align(
                                      alignment: Alignment.topLeft,
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
                                  Spacer(),
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Align(
                                          alignment: Alignment.bottomLeft,
                                          child: CircleAvatar(
                                            radius: 10.0,
                                          )
                                        ),
                                      ),
                                      Text(
                                        snapshot.data[index].username,
                                        style: TextStyle(
                                          color:Colors.white,
                                          fontSize:12,
                                          fontFamily: 'Source Sans Pro',
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              ),
                            ),
                          ),
                        );
                      }
                    );
                  }
                }
              })),
              Padding(
                padding: const EdgeInsets.all(9),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left:20.0),
                      child: Text("All Posts",
                        style: TextStyle(
                          fontSize:25,
                          fontFamily: 'Source Sans Pro',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    FutureBuilder(
                      future: getPosts(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal:10.0),
                              child: Center(
                                child: Text(
                                  "No connection.Check your internet connection",
                                  style: TextStyle(
                                  color: Color(0xffe6020a),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                                ),
                              ),
                            );
                          break;
                          case ConnectionState.active:
                          case ConnectionState.waiting:
                            return Container(
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    CircularProgressIndicator(),
                                    SizedBox(height: 10.0,),
                                    Text(
                                      "Loading posts",
                                    )
                                  ],
                                ),
                              ),
                            );
                          break;
                          case ConnectionState.done:
                          if (snapshot.hasError) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal:10.0),
                              child: Center(
                                child: Text(
                                  "Some problem occurred.Check your internet connection and try again!",
                                  style: TextStyle(
                                  color: Color(0xffe6020a),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                                ),
                              ),
                            );
                          } else if (snapshot.hasData) {
                          return  ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              var initial = snapshot.data[index].username;
                              /*Get the timestamp */
                              var date = DateTime.parse(snapshot.data[index].created_at);
                              /*Find the difference in time from now in seconds */
                              var difference = DateTime.now().difference(date).inDays;
                              
                              /*Format it into time ago */
                              var timeAgo = DateTime.now().subtract(Duration(seconds: difference));
                              var timestamp = (timeago.format(timeAgo));

                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    radius: 40,
                                    child: Text(
                                      "${initial[0]}${initial[1]}".toUpperCase(),
                                    ),
                                  ),
                                  title: Padding(
                                    padding: const EdgeInsets.only(bottom:15.0),
                                    child: Text(snapshot.data[index].title,
                                    style: TextStyle(
                                      fontFamily: 'Source Sans Pro',
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    ),
                                  ),
                                  subtitle: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.timelapse,
                                        size: 15,
                                      ),
                                      SizedBox(width: 5),
                                      Text("$timestamp",
                                      style: TextStyle(
                                        fontFamily: 'Source Sans Pro',
                                        fontSize: 10.0,
                                      ),
                                      ),
                                    ],
                                  ),
                                  trailing: Icon(Icons.arrow_forward_ios),
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => PostData(
                                        title:"${snapshot.data[index].title}",
                                        description: "${snapshot.data[index].description}",
                                        imageUrl: "${snapshot.data[index].imageUrl}",
                                        username: "${snapshot.data[index].username}",
                                      ),
                                    ));
                                  },
                                ),
                              );
                            }
                          );
                         }
                        }
                      }
                    ),
                  ],
                ),
              )
            ],
          ),
      )
    );    
  }
}