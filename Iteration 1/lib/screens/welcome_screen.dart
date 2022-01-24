import 'package:flutter/material.dart';
import 'package:nea_prototype_1/button.dart';
import 'package:nea_prototype_1/screens/signUp_screen.dart';

import 'home_screen.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  //final _formKey = GlobalKey<FormState>();
  late String username, password;
  bool isObscure = true;
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  @override
  Widget build(BuildContext context) {
    final myController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.cyan[600],
      body: Form(
      child:Container(
        margin: EdgeInsets.symmetric(horizontal: 25),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: myController,
                validator: (val){return val!.isEmpty ? "Enter Username" : null;},
                decoration: InputDecoration(
                  hintText: "Username"
                ),
                onChanged: (val){
                  username = val;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                obscureText: isObscure,
                validator: (val){return val!.isEmpty ? "Enter Password" : null;},
                decoration: InputDecoration(
                  hintText: "Password",
                  suffixIcon:IconButton(
                    icon: Icon(
                      isObscure ? Icons.visibility:
                      Icons.visibility_off),
                      onPressed: (){
                        setState(() {
                          isObscure = !isObscure;});},) ),
                onChanged: (val){
                  password = val;
                },
              ),
              SizedBox(height: 35),
                GenericButton("Login", () {
                  Navigator.push(context,MaterialPageRoute(builder: (context) =>HomeScreen(name: myController.text)));}),
                              SizedBox(height: 35),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("No account yet?  "),
                  GestureDetector(
                    onTap: (){Navigator.pushReplacement(context,MaterialPageRoute(
                          builder: (context) => SignUpScreen()));},
                    child: Text("Sign Up",
                    style: TextStyle(decoration: TextDecoration.underline),),
                  ),
                ],
              )
              //SizedBox(height: 50),
              // GenericButton("Login", () {
              //   Navigator.push(context,
              //       MaterialPageRoute(builder: (context) => LoginScreen()));
              // }),
              // SizedBox(height: 35.0),
              // GenericButton("Sign Up", () {
              //   Navigator.push(context,
              //       MaterialPageRoute(builder: (context) => SignUpScreen()));
              // })
            ],
          ),
      ),
        ),
    ));
  }
}