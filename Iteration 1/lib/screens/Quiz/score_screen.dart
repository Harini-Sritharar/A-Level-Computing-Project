//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nea_prototype_1/button.dart';
import 'package:nea_prototype_1/screens/BottomNavBar/bottom_nav_bar.dart';

import 'Menus/preset_quizzes_menu.dart';

class ScoreScreen extends StatelessWidget {
  final int points;
  final int numOfQs;
  ScoreScreen(this.points,this.numOfQs);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    int total = numOfQs * 10;
    return Scaffold(
        backgroundColor: Colors.deepPurple[200],
        body: Stack(
          children: <Widget>[
          Container(
            height: size.height * 0.45,
            decoration: BoxDecoration(
              color: Colors.deepPurple[300],
            ),
          ),
          Container(
            height: size.height * 0.35,
            decoration: BoxDecoration(
              color: Colors.deepPurple[500],
            ),
          ),
          Column(children: [
            SizedBox(height: 304.0),
            Center(
              child: Text("Score:",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic)),
            ),
            SizedBox(height: 30),
            Center(
              child: Text(("$points" + "/$total"),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 100.0),
            GenericButton("Menu", () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BottomNavBar()));
            }),
          ])
        ]));
  }
}
