import 'package:flutter/material.dart';
import 'package:nea_prototype_1/screens/Authentication/welcome_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import '../main.dart';
import 'home_screen.dart';

//import 'package:nea_prototype_1/screens/signUp_screen.dart';
class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}
class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final String initial = appUser.name[0];
    //name = myController.text;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        //title: Text("Hi " + widget.name + " !"),
        title: Text(appUser.name + "'s Profile"),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 45.0),
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.purple[100],
              child: Text(
                initial,
                textScaleFactor: 2,
              ),
            ),
            SizedBox(height: 45.0),
            Text(
              "Name: " + appUser.name,
              textScaleFactor: 1.5,
            ),
            SizedBox(height:20),         
            Text(
              "Email: " + appUser.email,
              textScaleFactor: 1.5,
            ),
            SizedBox(height:20),         
            Text(
              "Year Group: ${appUser.yearGroup}" ,
              textScaleFactor: 1.5,
            ),
            SizedBox(height:20),         
            Text(
              "Position: " + appUser.position,
              textScaleFactor: 1.5,
            ),        
          ],
        ),
      ),
    );
  }
}
