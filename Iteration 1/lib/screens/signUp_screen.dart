import 'package:flutter/material.dart';
import 'package:nea_prototype_1/screens/home_screen.dart';
import 'package:nea_prototype_1/button.dart';
import 'package:nea_prototype_1/screens/welcome_screen.dart';
//import 'package:nea_prototype_1/screens/profile_screen.dart';

class SignUpScreen extends StatefulWidget {
  // LoginScreen({Key? key, required this.title}) : super(key: key);
  // final String title;

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late String username, password;
  bool isObscure = true;
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final myController = TextEditingController();
    return Scaffold(
        backgroundColor: Colors.cyan[600],
        body: Form(
            child: Container(
                margin: EdgeInsets.symmetric(horizontal: 25),
                child: Center(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                      TextFormField(
                        controller: myController,
                        //validator: (val){return val!.isEmpty ? "Enter Username" : null;},
                        decoration: InputDecoration(hintText: "Name"),
                        onChanged: (val) {
                          username = val;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        //controller: myController,
                        //validator: (val){return val!.isEmpty ? "Enter Username" : null;},
                        decoration: InputDecoration(hintText: "Email"),
                        onChanged: (val) {
                          username = val;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        obscureText: isObscure,
                        //validator: (val){return val!.isEmpty ? "Enter Password" : null;},
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
                      GenericButton("Sign Up", () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    HomeScreen(name: myController.text)));
                      }),
                      SizedBox(height: 35),
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
                      )
                    ])))));
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
}
