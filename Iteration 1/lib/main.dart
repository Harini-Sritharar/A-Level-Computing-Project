//@dart=2.10
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nea_prototype_1/screens/welcome_screen.dart';
import 'package:nea_prototype_1/services/auth.dart';
import 'package:nea_prototype_1/services/database.dart';

AuthService authService = new AuthService();
DatabaseService databaseService = new DatabaseService();

void main() {
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //bool _isLoggedIn = false;
  @override
  // void initState(){
  //   checkLoginStatus();
  //   super.initState();
  // }

  // checkLoginStatus(){
  //    AuthService.getUserLoggedIn().then((value){
  //      setState(() {
  //        _isLoggedIn = value;
  //      });
  //    });
  // }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Revision Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      
      home: WelcomeScreen(),
      //(_isLoggedIn ?? false) ? HomeScreen(name: "") : 

      // home: HomeScreen(name: "Harini"),
      
    );
  }
}
