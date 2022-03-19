//@dart=2.10
//library globals;
import 'package:flutter/material.dart';
import 'package:nea_prototype_1/constants.dart';
import 'package:nea_prototype_1/models/user_details.dart';
import 'package:nea_prototype_1/screens/Authentication/welcome_screen.dart';
import 'package:nea_prototype_1/screens/custom_widgets.dart';
import 'package:nea_prototype_1/services/auth.dart';
import 'package:nea_prototype_1/services/database.dart';
// creating an instance of the following classes allows me to use easily in my code
AuthService authService = new AuthService();
DatabaseService databaseService = new DatabaseService();
UserDetails appUser = UserDetails("");
CustomWidgets customWidgets = CustomWidgets();
Constants constants = Constants();

void main() {
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Revision Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: WelcomeScreen(),
    );
  }
}
