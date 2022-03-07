import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nea_prototype_1/models/questionInfo.dart';
import 'package:nea_prototype_1/screens/Quiz/Navigation/quiz_screen_function.dart';
import 'package:random_string/random_string.dart';

class QuizNavigator extends StatefulWidget {
  final List<QuestionInfo> questionsAndOptions;

  QuizNavigator(this.questionsAndOptions);
  @override
  _QuizNavigatorState createState() => _QuizNavigatorState();
}

class _QuizNavigatorState extends State<QuizNavigator> {
  int currentQ = 0;
  int points = 0;
  bool endOfQuiz = false;
  bool answerSelected = false;
  List<QuizScreen> questions = [];


  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.questionsAndOptions.length; i++) {
      questions.add(QuizScreen(widget.questionsAndOptions[i], setNextQuestion,
          returnPreviousQuestion, checkQuizEnd, addPoints,randomBetween(1, 1000000)));
    }
  }

  void addPoints(int newPoints) {
    points += newPoints;
  }

  void setNextQuestion() {
    setState(() {
      if (currentQ < questions.length - 1) {
        currentQ++;
      } else {
        endOfQuiz = true;
      }
    });
  }

  void returnPreviousQuestion() {
    setState(() {
      if (currentQ != 0) {
        currentQ--;
      }
    });
  }

  checkQuizEnd() {
    return (currentQ + 1 == questions.length);
  }

  Widget build(BuildContext context) {
    return questions[currentQ];
  }
}
