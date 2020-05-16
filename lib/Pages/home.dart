import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:poetry/Models/post.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CrudMethods crudMethods = CrudMethods();
  QuerySnapshot blogs;

  int currentIndex;

  @override
    void initState(){
      super.initState();
      crudMethods.getData().then((result){
        blogs = result;
      });
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
      body: ListView(
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
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount:blogs.documents.length,
              itemBuilder: (context, index){
                return Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Card(
                    child: Container(
                      decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      image: DecorationImage(
                        image: NetworkImage(blogs.documents[index].data["imgUrl"]),
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
                                blogs.documents[index].data["title"],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28.0,
                                  fontFamily: 'Source Sans Pro',
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
                              blogs.documents[index].data["author"],
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
                );
              }
              ),
            ),
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
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: blogs.documents.length,
                    itemBuilder: (BuildContext context, int index) {
                      var initial = blogs.documents[index].data["author"];
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
                              child: Text(blogs.documents[index].data["title"],
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
                                Text("21 Minutes ago",
                                style: TextStyle(
                                  fontFamily: 'Source Sans Pro',
                                  fontSize: 10.0,
                                ),
                                ),
                              ],
                            ),
                            trailing: Icon(Icons.arrow_forward_ios),
                            onTap: (){},
                          ),
                      );
                    }
                  )
                ],
              ),
            )
          ],
        ),
    );
  }
}