import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nea_prototype_1/models/questionInfo.dart';
import 'package:nea_prototype_1/screens/Quiz/Navigation/quiz_screen_function.dart';
import 'package:random_string/random_string.dart';

class QuizNavigator extends StatefulWidget {
  // parameter for the class
  final List<QuestionInfo> questionsAndOptions;
  // constructor for the class
  QuizNavigator(this.questionsAndOptions);
  @override
  _QuizNavigatorState createState() => _QuizNavigatorState();
}

class _QuizNavigatorState extends State<QuizNavigator> {
  // initialising variables to default values
  int currentQ = 0;
  int points = 0;
  bool endOfQuiz = false;
  bool answerSelected = false;
  List<QuizScreen> questions = [];


  @override
  void initState() {
    super.initState();
    // for each question in the questionsAndOptions, create a QuizScreen and give it these paramaters shown below
    for (int i = 0; i < widget.questionsAndOptions.length; i++) {
      questions.add(QuizScreen(widget.questionsAndOptions[i], setNextQuestion,
          returnPreviousQuestion, checkQuizEnd,randomBetween(1, 1000000),checkLenQuiz));
    }
  }
  // function which adds the value of newPoints to the points variable
  void addPoints(int newPoints) {
    points += newPoints;
  }
  // function which naviagtes the user to the next question when they click 'skip' or 'submit'
  void setNextQuestion() {
    setState(() {
      if (currentQ < questions.length - 1) {
        currentQ++;
      } else {
        endOfQuiz = true;
      }
    });
  }
  // function which naviagtes the user to the previous question when they click 'back'
  void returnPreviousQuestion() {
    setState(() {
      if (currentQ != 0) {
        currentQ--;
      }
    });
  }
  // function which returns the length of the quiz
  int checkLenQuiz(){
    return questions.length;
  }
  // function which checks if the quiz has ended
  bool checkQuizEnd() {
    return (currentQ + 1 == questions.length);
  }
  // build function which returns all the questions of the current quiz
  Widget build(BuildContext context) {
    return questions[currentQ];
  }
}
