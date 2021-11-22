import 'package:flutter/material.dart';
//import 'package:nea_prototype_1/checkbox_tile.dart';
//import '../button.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  //bool _checkboxListTile = false;
  int numOfOptions = 4;
  late List<bool> _checkBoxSelected;
  late List<String> _checkBoxMessages;

  @override
  void initState() {
    super.initState();
    _checkBoxSelected = List.filled(numOfOptions, false);
    _checkBoxMessages = ["cos x","sin x", "tan x", "-sin x"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("What is dy/dx of cos x?"),
          centerTitle: true,
        ),
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
        ])));
  }
}
