// import 'package:flutter/material.dart';

// class Post extends StatefulWidget {
//   @override
//   _PostState createState() => _PostState();
// }

// class _PostState extends State<Post> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: LayoutBuilder(
//           builder: (context, _) => Stack(
//             children: <Widget>[
//               Positioned.fill(
//                 bottom: MediaQuery.of(context).size.height * .55,
//                 child: Image.network(
//                   widget.image,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               Positioned(
//                 top: 0,
//                 left: 0,
//                 right: 0,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     IconButton(
//                       icon: Icon(
//                         Icons.arrow_back_ios,
//                         color: Colors.white,
//                       ),
//                       onPressed: () => Navigator.pop(context),
//                     ),
//                     IconButton(
//                       icon: Icon(
//                         Icons.more_vert,
//                         color: Colors.white,
//                       ),
//                       onPressed: () {},
//                     ),
//                   ],
//                 ),
//               ),
//               Positioned.fill(
//                 child: DraggableScrollableSheet(
//                   initialChildSize: .80,
//                   minChildSize: .80,
//                   builder: (context, controller) => Container(
//                     padding: const EdgeInsets.all(15),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.only(
//                         topRight: Radius.circular(45),
//                         topLeft: Radius.circular(45),
//                       ),
//                     ),
//                     child: ListView(
//                       controller: controller,
//                       children: <Widget>[
//                         ListTile(
//                           leading: CircleAvatar(
//                             child: widget.avatar,
//                           ),
//                           title: Text(
//                             widget.author,
//                             style: TextStyle(
//                               fontFamily: 'Source Sans Pro',
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           subtitle: Row(
//                             children: <Widget>[
//                               Icon(
//                                 Icons.timelapse,
//                                 size: 15,
//                               ),
//                               SizedBox(width: 5),
//                               Text("21 Minutes ago",
//                                 style: TextStyle(
//                                   fontFamily: 'Source Sans Pro',
//                                   fontSize: 10.0,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           // trailing: Icon(
//                           //   Icons.whatshot,
//                           //   color: Colors.red,
//                           // ),
//                         ),
//                         SizedBox(height: 9.0),
//                         Column(
//                           children: <Widget>[
//                             Text(
//                               widget.title,
//                               style: TextStyle(
//                                 fontFamily: 'Source Sans Pro',
//                                 fontSize: 15.0,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             SizedBox(height: 9.0),
//                             Text(
//                               widget.description,
//                               style: TextStyle(
//                                 fontFamily: 'Source Sans Pro',
//                                 fontSize: 15.0,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
