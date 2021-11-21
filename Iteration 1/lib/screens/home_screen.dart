import 'package:flutter/material.dart';
import 'package:nea_prototype_1/button.dart';
import 'package:nea_prototype_1/screens/profile_screen.dart';
import 'package:nea_prototype_1/screens/quiz_questions_screen.dart';
//import 'package:nea_prototype_1/screens/signUp_screen.dart';
class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key, required this.name}) : super(key: key);
  //final String greeting;
  final String name;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: Colors.white,
     appBar: AppBar(
       //title: Text("Hi " + widget.name + " !"),
       title: Text(widget.name + "'s Home Page"),
       //title: Text("Hi Harini!"),
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
            Navigator.push(context,
                      MaterialPageRoute(
                          builder: (context) => ProfileScreen(name: widget.name,))); }),
          SizedBox(height: 35.0),
          GenericButton("Leaderboard", (){}),
          SizedBox(height: 35.0),
          GenericButton("Pre Set", (){
            Navigator.push(context,
                      MaterialPageRoute(
                          builder: (context) => QuizScreen())); }),
          SizedBox(height: 35.0),
          GenericButton("For You", (){})
          // () {
          //   Navigator.push(context,
          //             MaterialPageRoute(
          //                 builder: (context) => Leaderboard())); 
          
         ],
       )
       )
 
   ) ,
   );
   
  }}

class Leaderboard {
}