import 'package:flutter/material.dart';
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
      home: WelcomeScreen(title: "Flutter Quiz App"),
      //home: PresetMenu(),
      //home: ScoreScreen(15)
    );
  }
}
