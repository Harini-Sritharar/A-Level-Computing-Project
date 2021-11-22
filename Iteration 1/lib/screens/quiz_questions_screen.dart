import 'package:flutter/material.dart';
//import '../button.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  bool _checkboxListTile = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( "What is dy/dx of cos x?"),
        centerTitle: true,
      ),
      body:(
        Column(
          children: [
        CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          title: Text("sin x"),
          value: _checkboxListTile,
          onChanged: (value){
            setState(() {
            _checkboxListTile =! _checkboxListTile;
            });
          }
       ),
        CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        title: Text("cos x"),
        value: _checkboxListTile,
        onChanged: (value){
          setState(() {
            _checkboxListTile =! _checkboxListTile;
          });
        },
      )
          ]


       )
      )
    );
  }
}