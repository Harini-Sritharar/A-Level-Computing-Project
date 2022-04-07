import 'package:flutter/material.dart';
import 'package:nea_prototype_1/button.dart';
import 'package:nea_prototype_1/screens/BottomNavBar/bottom_nav_bar.dart';
class ScoreScreen extends StatelessWidget {
  // parameters
  final int points;
  final int numOfQs;
  // constructor 
  ScoreScreen(this.points,this.numOfQs);
  @override
  Widget build(BuildContext context) {
    // represents the size of the screen
    var size = MediaQuery.of(context).size;
    // represents the total score that the quiz is marked out of
    int total = numOfQs * 10;
    return Scaffold(
        backgroundColor: Colors.deepPurple[200],
        body: Stack(
          children: <Widget>[
            //UI code, creating the UI effect of stacked containers in the background of the screen
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
          //
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
              // shows the user's score out of total
              child: Text(("$points" + "/$total"),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 100.0),
            //button which naviagtes the user back to the Bottom Navigation Bar,which takes them to the Profile Screen
            GenericButton("Menu", () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BottomNavBar()));
            }),
          ])
        ]));
  }
}
