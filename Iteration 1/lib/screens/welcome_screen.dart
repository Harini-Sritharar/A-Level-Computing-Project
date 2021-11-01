import 'package:flutter/material.dart';
import 'package:nea_prototype_1/button.dart';
import 'package:nea_prototype_1/screens/login_screen.dart';
import 'package:nea_prototype_1/screens/signUp_screen.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[600],
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GenericButton("Login", () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            }),
            SizedBox(height: 35.0),
            GenericButton("Sign Up", () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignUpScreen()));
            })
          ],
        ),
      ),
    );
  }
}