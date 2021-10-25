import 'package:flutter/material.dart';
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
    final loginButton = (String msg, void Function() linkScreen) => Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(30.0),
        color: Color(0xFF26A69A), // color of login button
        child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: linkScreen,
            child: Text(msg,
                textAlign: TextAlign.center,
                style: style.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold))));
    return Scaffold(
      backgroundColor: Colors.cyan[200],
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            loginButton("Login", () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            }),
            SizedBox(height: 35.0),
            loginButton("Sign Up", () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignUpScreen()));
            })
          ],
        ),
      ),
    );
  }
}
