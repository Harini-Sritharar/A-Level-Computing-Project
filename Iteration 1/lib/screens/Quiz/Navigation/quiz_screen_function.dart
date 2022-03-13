import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nea_prototype_1/button.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:nea_prototype_1/models/questionInfo.dart';
import 'package:nea_prototype_1/screens/Quiz/score_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:random_string/random_string.dart';

// ignore: must_be_immutable
class QuizScreen extends StatefulWidget {
  //int points = 0;
  final void Function() setNextQuestion;
  final void Function() returnPreviousQuestion;
  final Function() checkQuizEnd;
  final Function(int newPoints) addPoints;
  final Function() checkLenQuiz;
  final int seed;
  

  final QuestionInfo questionInfo;
  QuizScreen(this.questionInfo, this.setNextQuestion,
      this.returnPreviousQuestion, this.checkQuizEnd, this.addPoints,this.seed,this.checkLenQuiz);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late final int numOfIncorrectOptions;
  int points = 0;
  late final List<bool> _checkBoxSelected;
  int numOfQs = 0;

//
  @protected
  @mustCallSuper
  void initState() {
    numOfIncorrectOptions = widget.questionInfo.incorrectOptions.length;
    _checkBoxSelected = List.filled(numOfIncorrectOptions + 1, false);
    numOfQs = widget.checkLenQuiz();
  }
  int chosenAnswer = 0;
  checkAnswer(int chosenAns) {
    String message = "Correct";
    Color? bgColour = Colors.green[300];
    if (chosenAns == 0) {
      points += 10;
    } else {
      bgColour = Colors.red[700];
      message = "Incorrect";
    }
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          if (!widget.checkQuizEnd()) {
            return GestureDetector(
              onTap: () {
                widget.setNextQuestion();
                Navigator.pop(context);
              },
              child: AlertDialog(
                backgroundColor: bgColour,
                title: Text(message),
              ),
            );
          } 
          else {
            return GestureDetector(
              child:
                  AlertDialog(backgroundColor: bgColour, title: Text(message)),
              onTap: () {
                pushNewScreen(
                    context,
                    screen: ScoreScreen(points,numOfQs),
                    withNavBar: true);
              },
            );
          }
        });
  }

  List<Widget> buildOptions() {
    List<RadioListTile> options = [];
    options.add(RadioListTile(
      title: Text(widget.questionInfo.correctOption),
      value: 0,
      groupValue: chosenAnswer,
      toggleable: true,
      onChanged: (value) {
        setState(() {
          if (value is int) {
            chosenAnswer = value;
            _checkBoxSelected[0] = !_checkBoxSelected[0];
          }
        });
      },
    ));
    for (int i = 0; i < numOfIncorrectOptions; i++) {
      options.add(RadioListTile(
        title: Text(widget.questionInfo.incorrectOptions[i]),
        value: i + 1,
        groupValue: chosenAnswer,
        toggleable: true,
        onChanged: (value) {
          setState(() {
            if (value is int) {
              chosenAnswer = value;
              _checkBoxSelected[i + 1] = !_checkBoxSelected[i + 1];
            }
          });
        },
      ));
    }
    //Random(seed) creates a random generator which is an object used
    // by any random object to create a random sequence. Based on the seed,
    // a sequence of random numbers will be created, because I want the ssame sequence
    // to be generated each time, i shuffle it with Random(seed) where the seed is generated
    // once and not changed. It is needed because when then user clicks on a option
    // the screen is reloaded with the chnage in effect but this also sreshuffles the optiosn
    // i wnat to reshuffle the optiosn with the same seed so that the order doesn't change
    options.shuffle(Random(widget.seed));
    return options;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: AutoSizeText(widget.questionInfo.questionName, maxLines: 1)),
      body: (Stack(children: [
        // // countdown timer => not essential at the moment and so can be included once essential features are completed
        // SafeArea(
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 50, vertical:50 ),
        //     child: Column(
        //       children: [
        //         Container(
        //           width: double.infinity,
        //           height: 50,
        //           decoration: BoxDecoration(
        //             border: Border.all(color: Colors.blue,
        //             width: 4),
        //             borderRadius: BorderRadius.circular(50)
        //           ),
        //           child: Stack(children: [
        //             LayoutBuilder(
        //               builder: (context,constraints) => Container(
        //                 width: constraints.maxWidth * 0.5,
        //                 decoration: BoxDecoration(
        //                   gradient: LinearGradient(
        //                     colors: [Color(0xFFB2DFDB), Color(0xFF00796B)],
        //                     begin: Alignment.centerLeft,
        //                     end: Alignment.centerRight),
        //                   borderRadius: BorderRadius.circular(50)
        //                 ),
        //               )),
        //           Positioned.fill(
        //             child: Padding(
        //               padding: const EdgeInsets.symmetric(horizontal: 25),
        //               child: Row(
        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 children: [
        //                   Text(" 20 seconds")
        //                 ],)
        //             )
        //               )
        //           ],)
        //         )
        //       ],
        //     ),)),
        // creating the radio buttons
        Divider(height: 30, indent: 10),
        Container(
          padding: EdgeInsets.all(0),
          child: Column(
            children: [
              for (Widget q in buildOptions())
              q,
              QuizButton("Skip", widget.setNextQuestion),
              QuizButton("Submit", () {
                checkAnswer(chosenAnswer);
              })
            ],
          ),
        )
      ])),
    );
  }
}
