class Comment {
  final String title;
  final String description;
  final String imageUrl;
  final String username;
  final String created_at;

  Comment(this.title, this.description, this.imageUrl, this.username, this.created_at);
}

// Padding(
//   padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 40.0),
//   child: ExpandablePanel(
//     header: Text("Comments",
//       style: TextStyle(
//         fontSize: 18.0,
//         fontFamily: 'Source Sans Pro'
//       ),
//     ),
//     expanded: Container(
//       height: 100.0,
//       child: FutureBuilder(
//         future: getPosts(),
//         builder: (BuildContext context, AsyncSnapshot snapshot) {
//           if (snapshot.hasData) {
//             return  ListView.builder(
//               itemCount: snapshot.data.length,
//               itemBuilder: (BuildContext context, int index){
//                 return ListTile(
//                   leading:Icon(
//                     Icons.account_circle,
//                     color: Colors.blue,
//                     size: 40.0,
//                   ),
//                   title: Padding(
//                     padding: const EdgeInsets.only(bottom:15.0),
//                     child: Text(snapshot.data[index].title,
//                     style: TextStyle(
//                       fontFamily: 'Source Sans Pro',
//                       fontSize: 15.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     ),
//                   ),
//                 );
//             },
//           );
//         } else if (snapshot.hasError) {
//             return Text("${snapshot.error}");
//         }/*By default, show a loading spinner */
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 CircularProgressIndicator(),
//                 SizedBox(height: 8.0),
//                 Text("Loading comments")
//               ],
//             ),
//           );      
//         }
//       ),
//     ),
//   ),
// ),