import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nea_prototype_1/screens/Quiz/Menus/by_you_quizzes_menu.dart';
import 'package:flutter/material.dart';
import 'package:nea_prototype_1/button.dart';
import 'package:nea_prototype_1/screens/profile_screen.dart';
import '../main.dart';
import 'Quiz/Menus/preset_quizzes_menu.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          // shows the user's name in the app bar
          title: Text(appUser.name + "'s Home Page"),
          centerTitle: true, // centres the title
        ),
        body: Center(
            child: Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment
                        .center, // all widgets are aligned in the ceetre of the page
                    children: <Widget>[
              GenericButton("Profile", () {
                // Profile Button
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()));
              }),
              SizedBox(height: 35.0),
              GenericButton("Leaderboard", () {
                // Leaderboard Button
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Awesome feature is in the works! 😎'),
                ));
              }),
              SizedBox(height: 35.0),
              GenericButton("Pre Set", () {
                // Preset Button
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PresetMenu()));
              }),
              SizedBox(height: 35.0),
              GenericButton("By You", () {
                // By You Button
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ByYouMenu()));
              }),
              SizedBox(height: 75.0),
            ]))));
  }
}
