//@dart=2.10
import 'package:flutter/material.dart';
import 'package:nea_prototype_1/constants.dart';
import 'package:nea_prototype_1/models/user_details.dart';
import 'package:nea_prototype_1/screens/Authentication/welcome_screen.dart';
import 'package:nea_prototype_1/custom_widgets.dart';
import 'package:nea_prototype_1/services/auth.dart';
import 'package:nea_prototype_1/services/database.dart';

//instance of the class that allows me to implement authorisation of users
AuthService authService = new AuthService();
//instance of the class that allows me to implement authorisation of users
DatabaseService databaseService = new DatabaseService();
//instance of the class that allows me to add, query and fetch data from the database
UserDetails appUser = UserDetails("");
//instance of the class that allows me to have a single appUser at a given time and store all the information about the current user
CustomWidgets customWidgets = CustomWidgets();
//instance of the class that allows me to utilise custom widgets that I have made in my CustomWidgets class
Constants constants = Constants();
//instance of the class that allows me to use constants without repeating them in multiple classes

void main() {
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  @override
  //creates a state for this widget
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // the line of code below removes the red debug banner which is by default set to true on all new flutter applications
      debugShowCheckedModeBanner: false,
      title: 'Revision Quiz App',
      theme: ThemeData(
        //denotes the colour that the theme is to be based upon
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //this line of code means that the user is navigated to the WelcomeScreen upon opening the app
      home: WelcomeScreen(),
    );
  }
}
