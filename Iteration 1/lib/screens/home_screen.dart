import 'package:flutter/material.dart';
import 'package:nea_prototype_1/button.dart';
import 'package:nea_prototype_1/screens/Authentication/welcome_screen.dart';
import 'package:nea_prototype_1/screens/Quiz/create_quiz.dart';
import 'package:nea_prototype_1/screens/preset_quizzes_menu.dart';
import 'package:nea_prototype_1/screens/profile_screen.dart';
import '../main.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key, required this.name}) : super(key: key);
  final String name;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => CreateQuiz()));
          },
          //backgroundColor: Colors.green,
          child: const Icon(Icons.add)),
      backgroundColor: Colors.white,
      appBar: AppBar(
        // currently just says Your Home Page, will later implement use of user's name --> Harini's Home Page / Profile etx
        title: Text(widget.name + " Home Page"),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: Center(
          child: Container(
              child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          //SizedBox(height: 50.0),
          GenericButton("Profile", () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfileScreen(
                          name: widget.name,
                        )));
          }),
          SizedBox(height: 35.0),
          GenericButton("Leaderboard", () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Awesome feature is in the works! 😎'),
            ));
          }),
          SizedBox(height: 35.0),
          GenericButton("Pre Set", () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => PresetMenu()));
          }),
          SizedBox(height: 35.0),
          GenericButton("By You", () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('I don\'t know who you are though 🤔'),
            ));
          }),
          SizedBox(height: 50.0),
          GenericButton("Sign Out", () {
            authService.signOut();
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => WelcomeScreen(),
                ));
          }),
          // () {
          //   Navigator.push(context,
          //             MaterialPageRoute(
          //                 builder: (context) => Leaderboard()));
        ],
      ))),
    );
  }
}

//class Leaderboard {}
