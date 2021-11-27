import 'package:flutter/material.dart';
//import 'package:nea_prototype_1/screens/quiz_questions_screen.dart';

import '../button.dart';

class Quiz extends StatefulWidget {
  @override
  _QuizState createState() => _QuizState();
  
} 
class _QuizState extends State<Quiz> {
  late String q;
  int numOfOptions = 2;
  int numOfQs = 2;
  late List<bool> _checkBoxSelected;
  // late List<String> _checkBoxMessages;
  late List<String> _checkBoxMessages;
  late List<String> questionsList = ["What is dy/dx of cos x?","What is dy/dx of sin x?"];
  @override
  void initState() {
    super.initState();
    _checkBoxSelected = List.filled(numOfOptions, false);
    _checkBoxMessages = ["cos x","sin x", "-sin x","sec x"];
  }
  @override
  Widget build(BuildContext context) {
      return Scaffold(
          body: (Column(children: [
            for (var i = 0; i < numOfOptions; i++)
              CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(_checkBoxMessages[i]),
                  value: _checkBoxSelected[i],
                  onChanged: (value) {
                    setState(() {
                      _checkBoxSelected[i] =! _checkBoxSelected[i];
                    });
                  }),
               QuizButton("Next", (){})
          ])),
            appBar: new AppBar(
            title: Text(q),
            centerTitle: true,
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
          ),);
  }
  }

