// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:poetry/Models/api.dart';
// import 'package:poetry/Models/post.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Home extends StatefulWidget {
//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   String username;
//   int currentIndex;

//   @override
//     void initState(){
//       super.initState();
//       getPosts();
//     }

//   /*Fetch the posts */
//   Future<List<Post>> getPosts() async {
//     SharedPreferences localStorage = await SharedPreferences.getInstance();
//     username = localStorage.getString('userKey');

//     var response = await CallAPi().getData('posts');
//     var jsonData = json.decode(response.body);

//     /*Create a list array to store the fetched data*/
//     List<Post> posts= [];

//     /*Loop through the jsonData and add the items to the list array created*/
//     for (var p in jsonData) {
//       Post post = Post(
//         p["postId"],
//         p["title"],
//         p["description"],
//         p["username"],
//         p["imageUrl"],
//       );

//       posts.add(post);
//     }

//     return posts;
  
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         title: Text(
//           'Poetry',
//           style:TextStyle(
//             color: Colors.black,
//             fontSize:27, 
//             fontFamily: 'Pacifico',
//           ),
//         ),
//         centerTitle: true,
//       leading: GestureDetector(
//         onTap: () {
//           Navigator.of(context).pop();
//         },
//           child: Icon(
//           Icons.menu,
//           size: 30.0,
//           color: Colors.black,
//         ),
//        ),
//        actions: <Widget>[
//          Padding(
//            padding: const EdgeInsets.all(8.0),
//            child: CircleAvatar(
//              radius: 15.0,
//            ),
//          ),
//        ],
//       ),
//       body: ListView(
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.only(left:20.0),
//             child: Text("Popular",
//               style: TextStyle(
//                 fontSize:25,
//                 fontFamily: 'Source Sans Pro',
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           Container(
//             height: MediaQuery.of(context).size.height * .30,
//             padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
//               return  ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: snapshot.data.documents.length,
//               itemBuilder: (context, index){
//                 return Container(
//                   width: MediaQuery.of(context).size.width * 0.6,
//                   child: Card(
//                     child: Container(
//                       decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12.0),
//                       image: DecorationImage(
//                         image: NetworkImage(snapshot.data.documents[index].data["imgUrl"]),
//                         fit: BoxFit.fill,
//                         colorFilter: new ColorFilter.mode(
//                           Colors.black.withOpacity(1.0),
//                           BlendMode.softLight,
//                         ),
//                       ),
//                     ),
//                     child: Column(
//                       children: <Widget>[
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Align(
//                             alignment: Alignment.topLeft,
//                               child: Text(
//                                 snapshot.data.documents[index].data["title"],
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 18.0,
//                                   fontFamily: 'Source Sans Pro',
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                                 ),
//                           ),
//                         ),
//                         Spacer(),
//                         Row(
//                           children: <Widget>[
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Align(
//                                 alignment: Alignment.bottomLeft,
//                                 child: CircleAvatar(
//                                   radius: 10.0,
//                                 )
//                               ),
//                             ),
//                             Text(
//                               snapshot.data.documents[index].data["author"],
//                               style: TextStyle(
//                                 color:Colors.white,
//                                 fontSize:12,
//                                 fontFamily: 'Source Sans Pro',
//                               ),
//                             ),
//                           ],
//                         )
//                       ],
//                     ),
//                     ),
//                   ),
//                 );
//               }
//               );
//               }
//             ),
//             Padding(
//               padding: const EdgeInsets.all(9),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Padding(
//                     padding: const EdgeInsets.only(left:20.0),
//                     child: Text("All Posts",
//                       style: TextStyle(
//                         fontSize:25,
//                         fontFamily: 'Source Sans Pro',
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   StreamBuilder(
//                     stream: blogs,
//                     builder: (context, snapshot){
//                     return  ListView.builder(
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(),
//                     itemCount: snapshot.data.documents.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       var initial = snapshot.data.documents[index].data["author"];
//                       var time = snapshot.data.documents[index].data["createdAt"];
//                       print(time);
//                       return Padding(
//                           padding: const EdgeInsets.all(10.0),
//                           child: ListTile(
//                             leading: CircleAvatar(
//                               radius: 40,
//                               child: Text(
//                                 "${initial[0]}${initial[1]}".toUpperCase(),
//                               ),
//                             ),
//                             title: Padding(
//                               padding: const EdgeInsets.only(bottom:15.0),
//                               child: Text(snapshot.data.documents[index].data["title"],
//                               style: TextStyle(
//                                 fontFamily: 'Source Sans Pro',
//                                 fontSize: 15.0,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                               ),
//                             ),
//                             subtitle: Row(
//                               children: <Widget>[
//                                 Icon(
//                                   Icons.timelapse,
//                                   size: 15,
//                                 ),
//                                 SizedBox(width: 5),
//                                 Text("21 Minutes ago",
//                                 style: TextStyle(
//                                   fontFamily: 'Source Sans Pro',
//                                   fontSize: 10.0,
//                                 ),
//                                 ),
//                               ],
//                             ),
//                             trailing: Icon(Icons.arrow_forward_ios),
//                             onTap: (){
//                               Navigator.push(context, MaterialPageRoute(
//                                 builder: (context) => Post(
//                                   avatar: Text("${initial[0]}${initial[1]}".toUpperCase(),),
//                                   title: snapshot.data.documents[index].data["title"],
//                                   image: snapshot.data.documents[index].data["imgUrl"],
//                                   author: snapshot.data.documents[index].data["author"],
//                                   description: snapshot.data.documents[index].data["description"],
//                                 ),
//                               ));
//                             },
//                           ),
//                       );
//                     }
//                   );
//                     }
//                   ),
//                 ],
//               ),
//             )
//           ],
//         )
//       );
          
//   }
// }