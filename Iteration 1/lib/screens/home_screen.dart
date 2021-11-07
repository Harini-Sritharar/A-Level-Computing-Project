import 'package:flutter/material.dart';
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
   ));
  }}