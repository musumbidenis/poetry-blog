import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<String> numbers = ['Title', 'Title', 'Title', 'Title', 'Title', 'Title', ];

int currentIndex;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // title: Text(
        //   'Poetry',
        //   style:TextStyle(fontSize:27, color: Colors.black),
        // ),
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
            child: Text("Popular",style: TextStyle(fontSize:25),),
          ),
          Container(
            height: MediaQuery.of(context).size.height * .35,
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount:numbers.length,
              itemBuilder: (context, index){
                return Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Card(
                    child: Container(
                      decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      image: DecorationImage(
                        image: NetworkImage('https://placeimg.com/640/480/any'),
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
                                numbers[index].toString(),
                                style: TextStyle(color: Colors.white, fontSize: 28.0),
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
                              "Author",
                              style: TextStyle(color:Colors.white, fontSize:15),
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
                    child: Text("All Posts",style: TextStyle(fontSize:25),),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: numbers.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 40,
                              child: Text('AJ'),
                            ),
                            title: Padding(
                              padding: const EdgeInsets.only(bottom:15.0),
                              child: Text('Understanding Peace in trying times'),
                            ),
                            subtitle: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.timelapse,
                                  size: 15,
                                ),
                                SizedBox(width: 5),
                                Text("21 Minutes ago"),
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