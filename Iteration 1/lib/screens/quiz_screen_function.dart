import 'package:flutter/material.dart';
import 'package:nea_prototype_1/button.dart';
import 'package:nea_prototype_1/questionInfo.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:auto_size_text/auto_size_text.dart';


class QuizScreen extends StatefulWidget {
  final int points = 0;
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
// void checkAnswer(bool questionInfo){
//     if ((questionInfo.score) = 1) {
//         points++;
//     }
// }
        
// screen for each question so the question validation should occur in here
class _QuizScreenState extends State<QuizScreen> {
  bool chosen = false;
    // List <String> chosen = [];
  // bool click = false;
  @override
  Widget build(BuildContext context) {
  return Scaffold(
      appBar: AppBar(
        title: AutoSizeText(widget.questionInfo.question, maxLines: 1,)
        ),
      body: (Column(
        children: [
        // creating the checkboxes
        for (var i = 0; i < widget.numOfOptions; i++)
          CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(widget.questionInfo.options[i]),
              //groupValue: widget._checkBoxSelected[0],
              value: widget._checkBoxSelected[i],
              //value: value,
              onChanged: (value) {
                setState(() {
                //groupValue = value;
                widget._checkBoxSelected[i] =! widget._checkBoxSelected[i];
                  
                  // if (chosen.length > 1){
                  //   chosen.removeAt(0);
                  //   print('selected length ${chosen.length}');
                  // }
                  // else{
                  //   print("only one");
                  // }
                });
              },
              ),

               QuizButton("Next", (){widget.setNextQuestion();}),
               QuizButton("Back", (){widget.returnPreviousQuestion();})
      ])),
  );
}
}
