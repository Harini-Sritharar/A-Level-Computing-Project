import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nea_prototype_1/models/user_details.dart';
import 'package:nea_prototype_1/screens/Authentication/welcome_screen.dart';
import 'package:nea_prototype_1/screens/BottomNavBar/bottom_nav_bar.dart';
import 'package:nea_prototype_1/services/auth.dart';
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
  AuthService authService = new AuthService();
  DatabaseService databaseService = new DatabaseService();
  late String name, email, yrGroup, position, password;
  bool _isLoading = false;
  bool isObscure = true;
  String dropdownVal = "7";
  final myController = TextEditingController();

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
            AuthService.saveUserLoggedIn(isLoggedIn: true);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.cyan[600],
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
                        TextFormField(
                          controller: myController,
                          validator: (val) {
                            return val!.isEmpty ? "Enter Name" : null;
                          },
                          decoration: InputDecoration(hintText: "Name"),
                          onChanged: (val) {
                            name = val;
                          },
                        ),
                        // EMAIL FIELD
                        SizedBox(height: 20),
                        TextFormField(
                          validator: (val) {
                            return val!.isEmpty ? "Enter Email" : null;
                          },
                          decoration: InputDecoration(hintText: "Email"),
                          onChanged: (val) {
                            email = val;
                          },
                        ),
                        // YEAR GROUP FIELD
                        SizedBox(height: 20),
                        // DropdownButton <String>(
                        //   value: dropdownVal,
                        //   icon: const Icon(Icons.arrow_circle_up),
                        //   elevation: 15,
                        //   style: const TextStyle(color: Colors.blueAccent),
                        //   underline: Container(
                        //     height: 3;
                        //     color: Colors.blueAccent,
                        //   ),
                        //   onChanged: (String? newVal){
                        //     setState(() {
                        //       dropdownVal = newVal!;
                        //     });
                        //   },
                        //   // items: <String>['7','8',],
                        //   )
                        // TextFormField(
                        //   validator: (val) {
                        //     return val!.isEmpty ? "Enter Year Group" : null;
                        //   },
                        //   decoration: InputDecoration(hintText: "Year Group"),
                        //   onChanged: (val) {
                        //     yrGroup = val;
                        //   },
                        // ),
                        // POSITION TOGGLE SWITCH
                        SizedBox(height: 20),
                        ToggleSwitch(
                            minHeight: 50,
                            minWidth: 170,
                            initialLabelIndex: 0,
                            totalSwitches: 2,
                            labels: ['Student', 'Teacher'],
                            onToggle: (index) {
                              position = (index == 0) ? "student" : "teacher";
                              print('switched to: $position');
                            }),
                        // TextFormField(
                        //   validator: (val) {
                        //     return val!.isEmpty ? "Enter Position" : null;
                        //   },
                        //   decoration:
                        //       InputDecoration(hintText: "Teacher or Student?"),
                        //   onChanged: (val) {
                        //     position = val;
                        //   },
                        // ),
                        SizedBox(height: 20),
                        // PASSWORD FIELD
                        TextFormField(
                          //controller: passwordController,
                          obscureText: isObscure,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return ("Enter Password");
                            }
                            if (val.length < 8) {
                              return ("Too short");
                            }
                            // return val!.isEmpty ? "Enter Password" : null;
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
                            onTap: () {
                              signUp();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              decoration: BoxDecoration(
                                  color: Colors.teal,
                                  borderRadius: BorderRadius.circular(30)),
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width - 40,
                              child: Text("Sign Up"),
                            )),
                        SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already made an account?  "),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WelcomeScreen()));
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 50)
                      ])))),
    );
  }
}

  // @override
  // Widget build(BuildContext context) {
  //   final nameField = TextField(
  //     controller: myController,
  //     obscureText: false,
  //     style: style,
  //     decoration: InputDecoration(
  //         fillColor: Colors.deepOrange[100],
  //         filled: true,
  //         contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
  //         labelText: "Enter Username",
  //         hintText: "Enter your username here",
  //         border:
  //             OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
  //   );
  //  final passwordField = TextField(
  //     obscureText: isObscure,
  //     style: style,
  //     decoration: InputDecoration(
  //         fillColor: Colors.deepOrange[100],
  //         filled: true,
  //         contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
  //         labelText: "Password",
  //         hintText: "Enter your password here",
  //         border:
  //             OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
  //         suffixIcon:IconButton(
  //           icon: Icon(
  //             isObscure ? Icons.visibility:
  //             Icons.visibility_off),
  //             onPressed: (){
  //               setState(() {
  //                 isObscure = !isObscure;
  //             });
  //           },
  //           ))  ,
  //   );
  //   return Scaffold(
  //       backgroundColor: Colors.deepOrange[400],
  //       appBar: AppBar(
  //           backgroundColor: Colors.deepOrange[300],
  //           //automaticallyImplyLeading: false
  //           ),
  //       body: Center(
  //           child: Container(
  //         child: Padding(
  //           padding: const EdgeInsets.all(36.0),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: <Widget>[
  //               //SizedBox(height:45.0),
  //               nameField,
  //               SizedBox(height: 45.0),
  //               passwordField,
  //               SizedBox(height: 45.0),
  //               GenericButton("Sign Up",() {
  //                 Navigator.push(context,
  //                 MaterialPageRoute(builder: (context) => HomeScreen(name: myController.text)));
  //               })
  //             ],
  //           ),
  //         ),
  //       )));
  // }
