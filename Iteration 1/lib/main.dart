//@dart=2.10
import 'package:flutter/material.dart';
import 'package:nea_prototype_1/helperFunctions.dart';
import 'package:nea_prototype_1/screens/home_screen.dart';
import 'package:nea_prototype_1/screens/signUp_screen.dart';
import 'package:nea_prototype_1/screens/welcome_screen.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedIn = false;
  @override
  void initState(){
    checkLoginStatus();
    super.initState();
  }

  checkLoginStatus(){
     HelperFunctions.getUserLoggedIn().then((value){
       setState(() {
         _isLoggedIn = value;
       });
     });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Revision Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(name: "Harini"),
      //(_isLoggedIn ?? false) ? HomeScreen(name: "Harini") : WelcomeScreen(),
      // if signed in, take to the home screen, else, take to the welcome screen where they can login or sign up
      
    );
  }
}
