import 'package:flutter/material.dart';
import 'package:nea_prototype_1/button.dart';
import 'package:nea_prototype_1/screens/signUp_screen.dart';

import 'home_screen.dart';

class WelcomeScreen extends StatefulWidget {
  //WelcomeScreen({Key? key, required this.title}) : super(key: key);
  //final String title;

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _formKey = GlobalKey<FormState>();
  late String email, password;

  signIn(id){
    if (_formKey.currentState!.validate()) {
      Navigator.push(context,MaterialPageRoute(builder: (context) => HomeScreen(name: id ),));
    }
  }
  bool isObscure = true;
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  @override
  Widget build(BuildContext context) {
    final myController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.cyan[600],
      body: Form(
        key: _formKey,
      child:Container(
        margin: EdgeInsets.symmetric(horizontal: 25),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: myController,
                validator: (val) {return val!.isEmpty ? "Enter Email" : null;},
                decoration: InputDecoration(
                  hintText: "Email"
                ),
                onChanged: (val){
                  email = val;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                obscureText: isObscure,
                validator: (val) {
                  if (val == null || val.isEmpty){
                    return "Enter password";
                  }
                  return null;},
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
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical:50),
              //   child: ElevatedButton(
              //     onPressed: (){
              //       signIn();

              //     }, 
              //     child: Text("Login"),
              //   )
              // ),
              // GenericButton("Login", (){
              //   signIn();
              //   Navigator.push(context, MaterialPageRoute(
              //             builder: (context) => HomeScreen(name: myController.text),));
              // }),
              GestureDetector(
                onTap: () {
                  signIn(myController.text);

                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(30) 
                  ),
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width - 40,
                  child: Text("Login"),
              )),
              //     // child: GenericButton("Login", () {
              //     //   Navigator.push(context,MaterialPageRoute(builder: (context) =>HomeScreen(name: myController.text)));}),
              //   ),
          
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
            ],
          ),
      ),
        ),
    ));
  }
}