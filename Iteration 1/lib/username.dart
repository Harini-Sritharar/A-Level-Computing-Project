import 'package:flutter/material.dart';

class NameField extends StatelessWidget {
  //final myController = TextEditingController();
  NameField({ Key? key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
    return TextField(
      //controller: myController,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          fillColor: Colors.deepPurple[100],
          filled: true,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          labelText: "Username",
          hintText: "Enter your username here",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
  }
}