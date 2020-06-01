import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:poetry/Pages/profile.dart';
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
    print(jsonData);
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
       actions: <Widget>[
         Padding(
           padding: const EdgeInsets.only(right: 10.0),
           child: InkWell(
              child: Icon(
               Icons.more_vert,
               size: 30.0,
               color: Colors.grey,
             ),
             onTap: (){
               Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
             },
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
                    if (snapshot.hasData) {
                      return  ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index){
                          var date = DateTime.parse(snapshot.data[index].created_at);
                          /*Find the difference in time from now in seconds */
                          var difference = DateTime.now().difference(date).inSeconds;
                          
                          /*Format it into time ago */
                          var timeAgo = DateTime.now().subtract(Duration(seconds: difference));
                          var timestamp = (timeago.format(timeAgo));
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
                                            child: Icon(
                                              Icons.account_circle,
                                              color: Colors.blue,
                                              size: 20.0,
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
                      },
                    );
                  } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                  }/*By default, show a loading spinner */
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
                ),),
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
                                  padding: const EdgeInsets.all(10.0),
                                  child: ListTile(
                                    leading:Icon(
                                      Icons.account_circle,
                                      color: Colors.blue,
                                      size: 70.0,
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
                                          Icons.query_builder,
                                          size: 10,
                                        ),
                                        Text("$timestamp",
                                        style: TextStyle(
                                          fontFamily: 'Source Sans Pro',
                                          fontSize: 8.0,
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
                                          timestamp: "$timestamp",
                                        ),
                                      ));
                                    },
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
                )
              ],
            ),
        ),
    );    
  }
}