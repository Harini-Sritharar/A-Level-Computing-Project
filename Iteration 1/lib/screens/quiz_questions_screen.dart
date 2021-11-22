import 'package:flutter/material.dart';
//import '../button.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  bool checkboxListTile = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( "What is dy/dx of cos x?"),
      ),
      body:(
      CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        title: Text("sin x"),
        value: checkboxListTile,
        onChanged: (value){
          setState(() {
            checkboxListTile = !checkboxListTile;
          });
        },
      )
       )
    );
  }
}