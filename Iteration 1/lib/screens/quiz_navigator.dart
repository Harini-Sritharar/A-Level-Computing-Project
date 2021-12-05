import 'package:flutter/cupertino.dart';
import 'package:nea_prototype_1/screens/quiz_screen_function.dart';
import '../questionInfo.dart';

class QuizNavigator extends StatefulWidget {
  final List<QuestionInfo> questionsAndOptions;

  QuizNavigator(this.questionsAndOptions);
  @override
  _QuizNavigatorState createState() => _QuizNavigatorState();

}

class _QuizNavigatorState extends State<QuizNavigator> {
  int currentQ = 0;
  bool endOfQuiz = false;
  bool answerSelected = false;
  List<QuizScreen> questions = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.questionsAndOptions.length; i++) {
      questions.add(QuizScreen(widget.questionsAndOptions[i],setNextQuestion,returnPreviousQuestion));
    }
  }

  void setNextQuestion() {
    setState(() {
      if (currentQ < questions.length - 1) {
        currentQ++;
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

  void checkQuizEnd() {
     if (currentQ + 1  == questions.length){
        endOfQuiz = true;
    }
  }
  // }
  // void questionAnswered() {
  //     setState(() {
  //       answerSelected = true;
  //       if (widget.questionsAndOptions = true){

  //       }
  //     });
  // }
  Widget build(BuildContext context) {
    return questions[currentQ];
  }
}
