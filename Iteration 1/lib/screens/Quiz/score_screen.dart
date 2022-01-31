//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nea_prototype_1/button.dart';
import 'package:nea_prototype_1/screens/preset_quizzes_menu.dart';

class ScoreScreen extends StatelessWidget {
  final int points;
  ScoreScreen(this.points);
@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[300],
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 340),
              Center(
                child: Text("Score:",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30,
                fontWeight: FontWeight.bold)
                ),),
              SizedBox(height: 30),
              Center(
                child: Text(("$points" + "/40"),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30,
                fontWeight: FontWeight.bold)
                ),),
              GenericButton("Menu", (){
                      Navigator.push(context,
                      MaterialPageRoute(
                          builder: (context) => PresetMenu()));}),

     
        ],)
      ],)
    );

  }
}