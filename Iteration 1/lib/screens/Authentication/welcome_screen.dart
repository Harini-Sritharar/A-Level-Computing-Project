import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nea_prototype_1/models/user_details.dart';
import 'package:nea_prototype_1/screens/bottom_nav_bar.dart';
import 'package:nea_prototype_1/services/auth.dart';

import '../../main.dart';
import '../home_screen.dart';
import 'signUp_screen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _formKey = GlobalKey<FormState>();
  late String email, password;
  AuthService authService = new AuthService();
  bool _isLoading = false;


  Future<void> signIn() async {
    setState(() {
      _isLoading = true;
    });
    // email = "student@gmail.com";
    // password = "student";
    // email = "teacher@gmail.com";
    // password = "teacherteacher";
    UserDetails? newUser =
        await authService.signInEmailAndPassword(email, password);
    if (newUser == "") {
      print("Null");
      _isLoading = true;
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => WelcomeScreen(),
          ));
      return;
    }

    //AuthService.saveUserLoggedIn(isLoggedIn: true);
    appUser = newUser;
    await appUser.initialise();
    setState(() {
      _isLoading = false;
    });
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BottomNavBar(),
        ));
  }

  bool isObscure = true;
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.cyan[600],
        // when loading the Progress Indicator will run, after loading, it wil go to the form
        body: _isLoading
            ? Container(
                child: Center(
                child: CircularProgressIndicator(),
              ))
            : Form(
                key: _formKey,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextFormField(
                          validator: (val) {
                            return val!.isEmpty ? "⚠️ Enter Email" : null;
                          },
                          decoration: InputDecoration(hintText: "Email"),
                          onChanged: (val) {
                            email = val;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          obscureText: isObscure,
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return "⚠️ Enter password";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: "Password",
                              suffixIcon: IconButton(
                                icon: Icon(isObscure
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    isObscure = !isObscure;
                                  });
                                },
                              )),
                          onChanged: (val) {
                            password = val;
                          },
                        ),
                        SizedBox(height: 35),
                        GestureDetector(
                            onTap: () async {
                              await signIn();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              decoration: BoxDecoration(
                                  color: Colors.teal,
                                  borderRadius: BorderRadius.circular(30)),
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width - 40,
                              child: Text("Login"),
                            )),
                        SizedBox(height: 35),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("No account yet?  "),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUpScreen()));
                              },
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ));
  }
}
