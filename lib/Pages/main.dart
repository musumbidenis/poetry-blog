import 'package:flutter/material.dart';
import 'package:poetry/Pages/home.dart';
import 'package:poetry/Pages/notification.dart';
import 'package:poetry/Pages/profile.dart';
import 'package:poetry/Pages/setings.dart';
import 'create.dart';


class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  // Properties & Variables needed

  int currentTab = 0; // to keep track of active tab index

  // to store nested tabs
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Home(); // Our first view in viewport

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButtonLocation: 
        FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        child: const Icon(
          Icons.edit,
        ), 
        onPressed: () {
          setState(() {
            currentScreen = CreatePost();
            currentTab = 4;
          });
        },
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 4.0,
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
              IconButton(
              iconSize: 25.0,
              padding: EdgeInsets.only(left: 28.0),
              icon: Icon(
                Icons.home,
                color: currentTab == 0 ? Colors.redAccent : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  currentScreen = Home();
                  currentTab = 0;
                });
              },
            ),
            IconButton(            
              iconSize: 25.0,
              padding: EdgeInsets.only(right: 28.0),
              icon: Icon(
                Icons.notifications,
                color: currentTab == 1 ? Colors.redAccent : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  currentScreen = Notify();
                  currentTab = 1;
                });
              },
            ),
            IconButton(
              iconSize: 25.0,
              padding: EdgeInsets.only(left: 28.0),
              icon: Icon(
                Icons.account_circle,
                color: currentTab == 2 ? Colors.redAccent : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  currentScreen = Profile();
                  currentTab = 2;
                });
              },
            ),
            IconButton(
              iconSize: 25.0,
              padding: EdgeInsets.only(right: 28.0),
              icon: Icon(
                Icons.settings,
                color: currentTab == 3 ? Colors.redAccent : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  currentScreen = Settings();
                  currentTab = 3;
                });
              },
            )
            ],
          ),
        ),
    );
  }
}