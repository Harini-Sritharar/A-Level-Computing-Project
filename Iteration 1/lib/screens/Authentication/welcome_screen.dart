import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
  

  bool _isLoading = false;
  bool invalidpassword = false;
  signIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService.signInEmailAndPassword(email, password).then((val) async {
        if (val != null) {
          setState(() {
            invalidpassword = false;
            _isLoading = false;
          });
          AuthService.saveUserLoggedIn(isLoggedIn: true);
          await databaseService.getName();

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(name:"name"),
              ));
        }
        else{
          invalidpassword = true;
          _isLoading = false;
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => WelcomeScreen(),
              ));

        }
        
      });
    }
  }

  bool isObscure = true;
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  @override
  Widget build(BuildContext context) {
    final myController = TextEditingController();
    return Scaffold(
        backgroundColor: Colors.cyan[600],
        // when loading the Progress Indicator will run, after loading, it wil go to the form
        body:
            _isLoading ? Container(
              child: Center(
                child: CircularProgressIndicator(),)
            ):
            Form(
          key: _formKey,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 25),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    controller: myController,
                    validator: (val) {
                      return val!.isEmpty ? "Enter Email" : null;
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
                        return "Enter password";
                      }
                      // if(invalidpassword = true){
                      //   return("Invalid password");
                      // }
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
                      onTap: () {
                        signIn();
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
                          style:
                              TextStyle(decoration: TextDecoration.underline),
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
