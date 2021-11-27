import 'package:flutter/material.dart';
//import 'package:nea_prototype_1/screens/quiz_questions_screen.dart';
//import 'package:nea_prototype_1/screens/quiz_questions_screen.dart';
import 'package:nea_prototype_1/screens/welcome_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Revision Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: WelcomeScreen(title: 'Revision Quiz App'),
      home: WelcomeScreen(title: "Flutter Quiz App"),
      //home: QuizScreen( ["cos x","sin x", "-sin x","sec x"], "What is dy/dx of cos x?"),

    );
  }
}


        //Navigator.push(
            //context,
            //MaterialPageRoute(builder: (context) => SecondRoute()),
          //);