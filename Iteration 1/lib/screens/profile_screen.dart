import 'package:flutter/material.dart';
import 'package:nea_prototype_1/screens/Authentication/welcome_screen.dart';
import 'package:nea_prototype_1/screens/preset_quizzes_menu.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'home_screen.dart';

//import 'package:nea_prototype_1/screens/signUp_screen.dart';
class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key, required this.name}) : super(key: key);
  //final String greeting;
  final String name;

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final String initial = widget.name[0];
    //name = myController.text;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        //title: Text("Hi " + widget.name + " !"),
        title: Text(widget.name + "'s Profile"),
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
              "Name: " + widget.name,
              textScaleFactor: 1.5,
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                "I am Groot",
                textScaleFactor: 3,
                style: TextStyle(color: Colors.purple),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
