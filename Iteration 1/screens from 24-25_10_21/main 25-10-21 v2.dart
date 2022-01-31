import 'package:flutter/material.dart';
import 'package:nea_prototype_1/screens/Authentication/welcome_screen.dart';


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
      home: WelcomeScreen(),
    );
  }
}


        //Navigator.push(
            //context,
            //MaterialPageRoute(builder: (context) => SecondRoute()),
          //);