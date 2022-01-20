import 'package:flutter/material.dart';
import 'package:nea_prototype_1/button.dart';
import 'package:nea_prototype_1/questionInfo.dart';
import 'package:auto_size_text/auto_size_text.dart';

class QuizScreen extends StatefulWidget {
  final numOfOptions = 4;
  late final List<bool> _checkBoxSelected;
  final void Function() setNextQuestion;
  final void Function() returnPreviousQuestion;
  final QuestionInfo questionInfo;
  QuizScreen(
      this.questionInfo, this.setNextQuestion, this.returnPreviousQuestion) {
    _checkBoxSelected = List.filled(numOfOptions, false);
  }
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

// screen for each question so the question validation should occur in here
class _QuizScreenState extends State<QuizScreen> {
  Object? chosenAnswer = 0;
  int points = 0;
  checkAnswer(chosenAns, rightIndex, points) {
    String message = "Correct";
    Color? bgColour = Colors.green[300];
    if (chosenAns == rightIndex) {
      points++;} 
    else {
      bgColour = Colors.redAccent[100];
      message = "Incorrect";}
    return showDialog(
      barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return GestureDetector(
            onTap: () {widget.setNextQuestion();Navigator.pop(context);},
            child: AlertDialog(
              backgroundColor: bgColour,
              title: Text(message),
           
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: AutoSizeText(
        widget.questionInfo.question,
        maxLines: 1,
      )),
      body: (Column(children: [
        // creating the radio buttons
        for (var i = 0; i < widget.numOfOptions; i++)
          RadioListTile(
            title: Text(widget.questionInfo.options[i]),
            value: i,
            groupValue: chosenAnswer,
            toggleable: true,
            onChanged: (value) {
              setState(() {
                chosenAnswer = value;
                widget._checkBoxSelected[i] = !widget._checkBoxSelected[i];
              });
            },
          ),
        QuizButton("Submit", () {
          checkAnswer(chosenAnswer, widget.questionInfo.correctIndex, points);
        }),
      ])),
    );
  }
}
