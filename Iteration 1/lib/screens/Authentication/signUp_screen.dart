import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nea_prototype_1/button.dart';
import 'package:nea_prototype_1/models/user_details.dart';
import 'package:nea_prototype_1/screens/Authentication/welcome_screen.dart';
import 'package:nea_prototype_1/screens/BottomNavBar/bottom_nav_bar.dart';
import 'package:nea_prototype_1/services/database.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../../main.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  late String name, email, yrGroup, position, password;
  bool _isLoading = false;
  bool isObscure = true;
  String dropdownVal = "7";

  signUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      UserDetails? newUser =
          await authService.signUpWithEmailAndPassword(email, password).then(
        (newUser) async {
          if (newUser != null) {
            setState(() {
              _isLoading = false;
            });
            appUser = newUser;
            await appUser.initialise();
            final FirebaseUser user = await auth.currentUser();
            final uid = user.uid;
            Map<String, dynamic> userData = {
              "name": name,
              "uid": uid,
              "email": email,
              "yearGroup": yrGroup,
              "position": position,
              "password": password
            };
            databaseService.addUserData(userData);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => BottomNavBar(),
                ));
          }
        },
      );
    }
  }

  Widget nameField() {
    return TextFormField(
      validator: (val) {
        return val!.isEmpty ? "⚠️ Enter Name" : null;
      },
      decoration: InputDecoration(
        icon: Icon(
          Icons.password,
          color: Colors.white,
        ),
        hintText: "Your Name",
      ),
      onChanged: (val) {
        name = val;
      },
    );
  }

  Widget emailField() {
    return TextFormField(
      validator: (val) {
        return val!.isEmpty ? "⚠️ Enter Email" : null;
      },
      decoration: InputDecoration(
        icon: Icon(
          Icons.password,
          color: Colors.white,
        ),
        hintText: "Your Email",
      ),
      onChanged: (val) {
        email = val;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('lib/assets/welcome_screen_bg.jpg')),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: _isLoading
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Form(
                key: _formKey,
                child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 25),
                    child: Center(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                          // NAME FIELD
                          customWidgets.customContainer(nameField()),
                          // EMAIL FIELD
                          SizedBox(height: 20),
                          customWidgets.customContainer(emailField()),
                          // YEAR GROUP DROPDOWN LIST
                          SizedBox(height: 20),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                                color: Colors.cyan[300],
                                borderRadius: BorderRadius.circular(30)),
                            child: Center(
                              child: Row(
                                children: [
                                  Icon(Icons.school, color: Colors.white),
                                  SizedBox(width: 10),
                                  Text("Year Group", textScaleFactor: 1.05),
                                  SizedBox(
                                    height: 10,
                                    width: 30,
                                  ),
                                  DropdownButton<String>(
                                    value: dropdownVal,
                                    icon: const Icon(
                                      Icons.arrow_circle_down_sharp,
                                    ),
                                    elevation: 25,
                                    style: const TextStyle(color: Colors.black),
                                    underline: Container(
                                      height: 2,
                                      color: Colors.blue,
                                    ),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdownVal = newValue!;
                                      });
                                    },
                                    items: <String>[
                                      '7',
                                      '8',
                                      '9',
                                      '10',
                                      '11',
                                      '12',
                                      '13',
                                      'Teacher (N/A)'
                                    ].map<DropdownMenuItem<String>>(
                                        (String val) {
                                      return DropdownMenuItem<String>(
                                        value: val,
                                        child: Text(val),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // POSITION TOGGLE SWITCH
                          SizedBox(height: 20),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                                color: constants.defaultBlueColour,
                                borderRadius: BorderRadius.circular(30)),
                            child: ToggleSwitch(
                                minHeight: 50,
                                minWidth: 150,
                                initialLabelIndex: 0,
                                totalSwitches: 2,
                                labels: ['Student', 'Teacher'],
                                onToggle: (index) {
                                  position =
                                      (index == 0) ? "student" : "teacher";
                                }),
                          ),
                          SizedBox(height: 20),
                          // PASSWORD FIELD
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                                color: Colors.cyan[300],
                                borderRadius: BorderRadius.circular(30)),
                            child: TextFormField(
                              obscureText: isObscure,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return ("Enter Password");
                                }
                                if (val.length < 8) {
                                  return ("Too short");
                                }
                              },
                              decoration: InputDecoration(
                                  icon: Icon(Icons.password),
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
                          ),
                          SizedBox(height: 35),
                          LoginButton('Sign Up', () {
                            signUp();
                          }),

                          SizedBox(height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Already made an account?  ",
                                  style: TextStyle(color: Colors.white)),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              WelcomeScreen()));
                                },
                                child: Text(
                                  "Login",
                                  style: constants.underlineStyle,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 50)
                        ])))),
      ),
    );
  }
}
