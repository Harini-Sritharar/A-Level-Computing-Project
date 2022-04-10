import 'package:flutter/material.dart';
import 'package:nea_prototype_1/main.dart';

class ClassQuizScreen extends StatefulWidget {
  // parameter
  final int value;
  // constructor
  const ClassQuizScreen(this.value);
  @override
  State<ClassQuizScreen> createState() => _ClassQuizScreenState();
}

class _ClassQuizScreenState extends State<ClassQuizScreen> {
  @override
  Widget build(BuildContext context) {
    // represents the class selected from the classes screen
    var currentClass = appUser.classes[widget.value];
    if (currentClass.quizzes.length > 0) {
      // if there are quizzes
      return Container(
        decoration: BoxDecoration(color: Colors.blue),
        height: 200,
        child: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            children: [
              // returns a clickable card for each quiz
              for (int i = 0; i < currentClass.quizzes.length; i++)
                customWidgets.createCard(
                    i, context, appUser.classes[widget.value].quizzes)
            ]),
      );
    } else {
      // if there are no quizzes
      return Scaffold(
          backgroundColor: Colors.blue,
          body: Container(
              child: Center(
            child: Text(
              'No quizzes added yet! :(',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          )));
    }
  }
}
