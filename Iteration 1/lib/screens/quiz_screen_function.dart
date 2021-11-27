//import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:nea_prototype_1/button.dart';

//import 'home_screen.dart';
//import 'package:nea_prototype_1/checkbox_tile.dart';
import '../button.dart';

class QuizScreen extends StatefulWidget {
  final numOfOptions = 4;
  late final List<bool> _checkBoxSelected;
  final List<String> _checkBoxMessages;
  final String question; 
   QuizScreen(this._checkBoxMessages,this.question) {
     _checkBoxSelected = List.filled(numOfOptions, false);
   }
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  Widget build(BuildContext context) {
  return Scaffold(
      appBar: AppBar(
        title: Text(widget.question),
        centerTitle: true),
      body: (Column(
        children: [
        for (var i = 0; i < widget.numOfOptions; i++)
          CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(widget._checkBoxMessages[i]),
              value: widget._checkBoxSelected[i],
              onChanged: (value) {
                setState(() {
                  widget._checkBoxSelected[i] =! widget._checkBoxSelected[i];
                });
              }),
            QuizButton("Next", (){
            Navigator.push(context,
                      MaterialPageRoute(
                          builder: (context) => QuizScreen( ["tan x","sin x","- sec x","cos x"], "What is dy/dx of sin x?"))); })
      ])),

          // Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //               builder: (context) =>
          //                   HomeScreen(name: "Harini")));})
        // CheckboxListTile(
        // controlAffinity: ListTileControlAffinity.leading,
        // title: Text("cos x"),
        // value: _checkboxListTile,
        // onChanged: (value){
        //   setState(() {
        //     _checkboxListTile =! _checkboxListTile;
        //   });
        // },
        // )
  );
}
}
