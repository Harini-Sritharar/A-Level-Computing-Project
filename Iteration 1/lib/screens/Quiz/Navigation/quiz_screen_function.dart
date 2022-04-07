// import dependencies
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:nea_prototype_1/button.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:nea_prototype_1/main.dart';
import 'package:nea_prototype_1/models/questionInfo.dart';
import 'package:nea_prototype_1/screens/Quiz/score_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class QuizScreen extends StatefulWidget {
  // parameters
  final void Function() setNextQuestion;
  final void Function() returnPreviousQuestion;
  final Function() checkQuizEnd;
  final Function() checkLenQuiz;
  final int seed;
  final QuestionInfo questionInfo;
  // constructor
  QuizScreen(
      this.questionInfo,
      this.setNextQuestion,
      this.returnPreviousQuestion,
      this.checkQuizEnd,
      this.seed,
      this.checkLenQuiz);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late final int numOfIncorrectOptions;
  late final List<bool> _checkBoxSelected;
  int points = 0;
  int numOfQs = 0;
  int chosenAnswer = 0;
//
  @protected
  @mustCallSuper
  // this function sets the 3 variables to the values depending on the current question
  void initState() {
    numOfIncorrectOptions = widget.questionInfo.incorrectOptions.length;
    _checkBoxSelected = List.filled(numOfIncorrectOptions + 1, false);
    numOfQs = widget.checkLenQuiz();
  }

  checkAnswer(int chosenAns) {
    // the default message and bgColour are declared here
    String message = "Correct";
    Color? bgColour = Colors.green[300];
    // if the answer chosen is correct, the points increment
    if (chosenAns == 0) {
      points += 10;
    } else {
      // if the answer chosen is incorrect, the default message and bgColour change
      bgColour = Colors.red[700];
      message = "Incorrect";
    }
    return showDialog(
        // returns a Dialog
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          // if the quiz had not ended yet
          if (!widget.checkQuizEnd()) {
            return GestureDetector(
              // when the dialog is tapped, the next question is loaded in
              onTap: () {
                widget.setNextQuestion();
                Navigator.pop(context);
              },
              // creates an AlertDialog with the relevant background colour and message
              child: AlertDialog(
                backgroundColor: bgColour,
                title: Text(message),
              ),
            );
          }
          // if current question is the last question
          else {
            return GestureDetector(
              child:
                  AlertDialog(backgroundColor: bgColour, title: Text(message)),
              onTap: () {
                // navigate the user to the ScoreScreen
                pushNewScreen(context,
                    screen: ScoreScreen(points, numOfQs), withNavBar: true);
              },
            );
          }
        });
  }

  // function which build the options layout of the screen
  List<Widget> buildOptions() {
    // initialises an empty list called options
    List<RadioListTile> options = [];
    // adds the RadioListTile representing the correct answer
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
    // adds the RadioListTiles representing the incorrect answers
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
    // shuffles the options using Random(seed)
    options.shuffle(Random(widget.seed));
    return options;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AutoSizeText(widget.questionInfo.questionName, maxLines: 1),
        centerTitle: true,
        // removes the back button from the app bar
        automaticallyImplyLeading: false,
      ),
      body: (Stack(children: [
        // creating the radio buttons
        SizedBox(height: 70),
        Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                height: 35,
              ),
              for (Widget answer in buildOptions())
                customWidgets.customContainer(answer),
              // Takes the user to the next question
              QuizButton("Skip", widget.setNextQuestion),
              // runs the checkAnswer function on the answer chosen by the user
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
