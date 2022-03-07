import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nea_prototype_1/screens/Quiz/Menus/by_you_quizzes_menu.dart';
import 'package:nea_prototype_1/services/database.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:flutter/material.dart';
import 'package:nea_prototype_1/button.dart';
import 'package:nea_prototype_1/screens/Authentication/welcome_screen.dart';

import 'package:nea_prototype_1/screens/profile_screen.dart';
import '../main.dart';
import 'Quiz/Create Quiz/create_quiz.dart';
import 'Quiz/Menus/preset_quizzes_menu.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key, required this.name}) : super(key: key);
  final String name;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  void initState() {
    super.initState();
  }

  final Stream<QuerySnapshot> users =
      Firestore.instance.collection("Users").snapshots();
  
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(appUser.name + "'s Home Page"),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CreateQuiz()));
            },
            child: const Icon(Icons.add)),

        // floatingActionButton: FloatingActionButton(
        //     onPressed: () {
        //       Navigator.push(context,
        //           MaterialPageRoute(builder: (context) => CreateQuiz()));
        //     },
        //     child: const Icon(Icons.add)),
        // body: Center(
        //   child: Container(
        //     height: 500, 
        //     child: StreamBuilder<QuerySnapshot>(
        //         stream: users,
        //         builder: (BuildContext context,
        //             AsyncSnapshot<QuerySnapshot> snapshot) {
        //           if (snapshot.hasError) {
        //             return Text("Something went wrong");
        //           }
        //           if (snapshot.connectionState == ConnectionState.waiting) {
        //             return Text("Loading");
        //           }
        //            //final data = snapshot.data;

        //           final data = snapshot.requireData.documents;

        //           return ListView.builder(
        //             itemCount: data.length,
        //             itemBuilder: (context,index){
        //               return Text('${appUser.name}Users name is ${data[index]['name']}');
        //             });

        //         }),
        //   ),
        // )
        // this is the body with the buttons
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PresetMenu()));
              }),
              SizedBox(height: 35.0),
              GenericButton("By You", ()async {await databaseService.getQuizzes();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ByYouMenu()));
              }),
              SizedBox(height: 75.0),
              GenericButton("Sign Out", () {
                authService.signOut();
                Navigator.of(context,rootNavigator: true).pushAndRemoveUntil( MaterialPageRoute(
                      builder: (context) => WelcomeScreen(),
                    ), (route) => false);
              }),
            ])))
        );
  }
}

  // ],
  // ))


