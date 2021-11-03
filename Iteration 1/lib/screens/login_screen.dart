import 'package:flutter/material.dart';
import 'package:nea_prototype_1/button.dart';
import 'package:nea_prototype_1/screens/profile_screen.dart';
//import 'package:nea_prototype_1/username.dart';

class LoginScreen extends StatefulWidget {
  // LoginScreen({Key? key, required this.title}) : super(key: key);
  // final String title;
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isObscure = true;
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final myController = TextEditingController();
  //get title => null;
  @override
  Widget build(BuildContext context) {
    final nameField = TextField(
      controller: myController,
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

    final passwordField = TextField(
      obscureText: isObscure,
      style: style,
      decoration: InputDecoration(
          fillColor: Colors.deepPurple[100],
          filled: true,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          labelText: "Password",
          hintText: "Enter your password here",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          suffixIcon:IconButton(
            icon: Icon(
              isObscure ? Icons.visibility:
              Icons.visibility_off),
              onPressed: (){
                setState(() {
                  isObscure = !isObscure;
              });
            },
            ))  ,  
    );
    return Scaffold(
        backgroundColor: Colors.deepPurple[400],
        appBar: AppBar(
          backgroundColor: Colors.deepPurple[300],
          //automaticallyImplyLeading: false
        ),
        body: Center(
            child: Container(
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                nameField,
                SizedBox(height: 45.0),
                passwordField,
                SizedBox(height: 45.0),
                GenericButton("Login", () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ProfileScreen(name: myController.text)));
                })
              ],
            ),
          ),
        )));
  }
}
