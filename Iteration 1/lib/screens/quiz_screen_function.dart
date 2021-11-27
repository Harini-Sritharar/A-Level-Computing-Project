import 'package:flutter/material.dart';
import 'package:nea_prototype_1/button.dart';
import 'package:nea_prototype_1/questionInfo.dart';

class QuizScreen extends StatefulWidget {
  final numOfOptions = 4;
  late final List<bool> _checkBoxSelected;
  final void Function() setNextQuestion;
  final QuestionInfo questionInfo;
  QuizScreen(this.questionInfo, this.setNextQuestion) {
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
        title: Text(widget.questionInfo.question),
        centerTitle: true),
      body: (Column(
        children: [
        for (var i = 0; i < widget.numOfOptions; i++)
          CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(widget.questionInfo.options[i]),
              value: widget._checkBoxSelected[i],
              onChanged: (value) {
                setState(() {
                  widget._checkBoxSelected[i] =! widget._checkBoxSelected[i];
                });
              }),
               QuizButton("Next", (){widget.setNextQuestion();})
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
