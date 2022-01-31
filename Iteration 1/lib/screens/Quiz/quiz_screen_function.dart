import 'package:flutter/material.dart';
import 'package:nea_prototype_1/button.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:nea_prototype_1/screens/Quiz/score_screen.dart';
import '../questionInfo.dart';


// ignore: must_be_immutable
class QuizScreen extends StatefulWidget {
  //int points = 0;
  final void Function() setNextQuestion;
  final void Function() returnPreviousQuestion;
  final Function() checkQuizEnd;
  final Function(int newPoints) addPoints;

  final QuestionInfo questionInfo;
  QuizScreen(this.questionInfo, this.setNextQuestion,
      this.returnPreviousQuestion, this.checkQuizEnd, this.addPoints);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

// screen for each question so the question validation should occur in here
class _QuizScreenState extends State<QuizScreen> {
  final numOfOptions = 4;
  late final List<bool> _checkBoxSelected;

  @protected
  @mustCallSuper
  void initState() {
    _checkBoxSelected = List.filled(numOfOptions, false);
  }

  Object? chosenAnswer = 0;
  //setState((){points = 0});
  checkAnswer(chosenAns, rightIndex) {
    String message = "Correct";
    Color? bgColour = Colors.green[300];
    if (chosenAns == rightIndex) {
      widget.addPoints(10);
      //return (points);
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
          // to navigate from the final question to the score sreen
          else {
            return GestureDetector(
              child:
                  AlertDialog(backgroundColor: bgColour, title: Text(message)),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ScoreScreen(10)));
              },
            );
          }
        });
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

        // Question in body of screen rather than in appbar
        // Text.rich(
        //   TextSpan(
        //     text: (widget.questionInfo.question),
        //     style: Theme.of(context).textTheme.headline5!.copyWith(color: Color(0xFF42A5f5)),
        //     children: [
        // ],)),
        // creating the radio buttons
        Divider(height: 30, indent: 10),
        Container(
          padding: EdgeInsets.all(0),
          decoration: BoxDecoration(
              color: Colors.blue[200],
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(color: Color(0xFF42A5F5), spreadRadius: 3)
              ]),
          child: Column(
            children: [
              for (var i = 0; i < numOfOptions; i++)
                RadioListTile(
                  title: Text(widget.questionInfo.options[i]),
                  value: i,
                  groupValue: chosenAnswer,
                  toggleable: true,
                  onChanged: (value) {
                    setState(() {
                      chosenAnswer = value;
                      _checkBoxSelected[i] =
                          !_checkBoxSelected[i];
                    });
                  },
                ),
              QuizButton("Skip", widget.setNextQuestion),
              QuizButton("Submit", () {
                checkAnswer(chosenAnswer, widget.questionInfo.correctIndex);
              })
            ],
          ),
        )
      ])),
    );
  }
  //  Widget build(BuildContext context) {
  //    return Stack(
  //      children: [
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