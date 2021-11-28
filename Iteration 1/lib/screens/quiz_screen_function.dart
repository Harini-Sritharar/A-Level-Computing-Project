import 'package:flutter/material.dart';
import 'package:nea_prototype_1/button.dart';
import 'package:nea_prototype_1/questionInfo.dart';

class QuizScreen extends StatefulWidget {
  final numOfOptions = 4;
  late final List<bool> _checkBoxSelected;
  final void Function() setNextQuestion;
  final void Function() returnPreviousQuestion;
  final QuestionInfo questionInfo;
  QuizScreen(this.questionInfo, this.setNextQuestion,this.returnPreviousQuestion) {
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
        title: Text(widget.questionInfo.question)
        //, style: TextStyle(fontSize: 13.5)
        ),
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
               QuizButton("Next", (){widget.setNextQuestion();}),
               QuizButton("Back", (){widget.returnPreviousQuestion();})
      ])),
  );
}
}
