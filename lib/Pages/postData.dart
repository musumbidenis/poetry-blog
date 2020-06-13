import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:poetry/Models/api.dart';
import 'package:poetry/Models/post.dart';

class PostData extends StatefulWidget {
  final String postId, title, description, username, imageUrl, timestamp;

  const PostData({Key key, this.postId,this.title, this.description, this.username, this.imageUrl, this.timestamp}) : super(key: key);
  @override
  _PostDataState createState() => _PostDataState();
}

class _PostDataState extends State<PostData> {
  bool buttonEnabled = false;

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
        p["postId"],
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
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, _) => Stack(
            children: <Widget>[
              Positioned.fill(
                bottom: MediaQuery.of(context).size.height * .55,
                child: Image.network(
                  widget.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.more_vert,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              Positioned.fill(
                child: DraggableScrollableSheet(
                  initialChildSize: .80,
                  minChildSize: .80,
                  builder: (context, controller) => Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(45),
                        topLeft: Radius.circular(45),
                      ),
                    ),
                    child: ListView(
                      controller: controller,
                      children: <Widget>[
                        ListTile(
                          leading: Icon(
                            Icons.account_circle,
                            color: Colors.blue,
                            size: 50.0,
                          ),
                          title: Text(
                            widget.username,
                            style: TextStyle(
                              fontFamily: 'Source Sans Pro',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Row(
                            children: <Widget>[
                              Icon(
                                Icons.query_builder,
                                size: 10,
                              ),
                              Text(widget.timestamp,
                                style: TextStyle(
                                  fontFamily: 'Source Sans Pro',
                                  fontSize: 8.0,
                                ),
                              ),
                            ],
                          ),
                          // trailing: Icon(
                          //   Icons.whatshot,
                          //   color: Colors.red,
                          // ),
                        ),
                        SizedBox(height: 9.0),
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 60.0),
                              child: Text(
                                widget.title,
                                style: TextStyle(
                                  fontFamily: 'Source Sans Pro',
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(height: 9.0),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 40.0),
                              child: Text(
                                widget.description,
                                style: TextStyle(
                                  fontFamily: 'Source Sans Pro',
                                  fontSize: 15.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        bottomSheet: ListTile(
          leading: Icon(
            Icons.account_circle,
            color: Colors.blue,
            size: 50.0,
          ),
          title: TextFormField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Add a comment',
              labelStyle: TextStyle(
                fontFamily: 'Source Sans Pro',
                fontWeight: FontWeight.bold,
                color: Colors.grey
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent)
            ),
          ),
          keyboardType: TextInputType.text,
          validator: (String val){
            if(val.isEmpty){
              setState(() {
                buttonEnabled = false;
              });
            }else{
              setState(() {
                buttonEnabled = true;
              });
            }
            
          },
          ),
          trailing: FlatButton(
            onPressed: buttonEnabled == true ? (){} : null,
            child: Text("post",
              style: TextStyle(
                color: Colors.blue,
                fontFamily: 'Source Sans Pro',
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
