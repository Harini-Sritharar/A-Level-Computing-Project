import 'package:flutter/material.dart';
import 'package:nea_prototype_1/button.dart';
import 'package:nea_prototype_1/questionInfo.dart';
import 'package:auto_size_text/auto_size_text.dart';
// ignore: import_of_legacy_library_into_null_safe
//import 'package:websafe_svg/websafe_svg.dart';

// ignore: must_be_immutable
class QuizScreen extends StatefulWidget {
  final numOfOptions = 4;
  late final List<bool> _checkBoxSelected;
  final void Function() setNextQuestion;
  final void Function() returnPreviousQuestion;
  var checkQuizEnd;
  final QuestionInfo questionInfo;
  QuizScreen(
      this.questionInfo, this.setNextQuestion, this.returnPreviousQuestion, this.checkQuizEnd) {
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
      bgColour = Colors.red[700];
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
          }
        );
   }

  // showScore(checkEnd){
  //   if (widget.checkQuizEnd){

  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: AutoSizeText(
        widget.questionInfo.question,
        maxLines: 1,
      ),
      ),
      body: (
    Column(children: [
      // countdown timer
      SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical:50 ),
          child: Column(
            children: [ 
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue,
                  width: 4),
                  borderRadius: BorderRadius.circular(50)
                ),
                child: Stack(children: [LayoutBuilder(builder: (context,constraints) => Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFB2DFDB), Color(0xFF00796B)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight),
                    borderRadius: BorderRadius.circular(50)
                  ),
                )),
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(" 20 seconds")
                      ],)
                  )
                    )
                ],)
              )
            ],
          ),)),
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
          QuizButton("Skip", widget.setNextQuestion),
          QuizButton("Submit", () {
            checkAnswer(chosenAnswer, widget.questionInfo.correctIndex, points);

          }),
        ])),
    );
  }
      //  Widget build(BuildContext context) {
      //    return Stack(
      //      children: [
      //        //WebsafeSvg.asset("lib/assets/quizbg.svg"),
      //        SafeArea(
      //          child: Padding(
      //            padding: const EdgeInsets.symmetric(horizontal:20),
      //            child: Column(children: [Container(
      //              width: double.infinity,
      //              height:50,
      //             color: Colors.purple[200],
      //            )],))
      //        )
      //      ],
      //    );
      //  }
}
