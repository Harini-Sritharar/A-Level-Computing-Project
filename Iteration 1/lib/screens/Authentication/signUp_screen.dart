// imports
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nea_prototype_1/button.dart';
import 'package:nea_prototype_1/models/user_details.dart';
import 'package:nea_prototype_1/screens/Authentication/welcome_screen.dart';
import 'package:nea_prototype_1/services/database.dart';
import 'package:nea_prototype_1/screens/Walkthrough/walkthrough.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../../main.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  
  final _formKey = GlobalKey<FormState>();
  // initialising these fields with default values
  late String name, email, password;
  String yrGroup = '7', position = 'student';
  bool _isLoading = false;
  bool isObscure = true;
  String dropdownVal = "";
  final myController = TextEditingController();

  // signUp function which is run when the user clicks the Sign Up button
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
            // fetches the details of the current user
            final FirebaseUser user = await auth.currentUser();
            // fetches the uid of the current user
            final uid = user.uid;
            // creates a map which stores the user's data as key-value pairs
            Map<String, dynamic> userData = {
              "name": name,
              "uid": uid,
              "email": email,
              "yearGroup": yrGroup,
              "position": position,
              "password": password
            };
            // the addUserData function is called
            databaseService.addUserData(userData);
            await appUser.initialise();
            // navigates the user to the walkthrough
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => WalkthroughScreen(),
                ));
          }
        },
      );
    }
  }
  // widget which creates the name field
  Widget nameField() {
    return TextFormField(
      validator: (val) {
        return val!.isEmpty ? "Enter Name" : null;
      },
      // icon to be shown to highlight the purpose of the field
      decoration: customWidgets.whiteIconDecor(Icons.person, 'Name'),
      onChanged: (val) {
        name = val; // value entered will be stored in name 
      },
    );
  }

  // widget which creates the email field
  Widget emailField() {
    return TextFormField(
      validator: (val) {
        return val!.isEmpty ? "Enter Email" : null;
      },
      // icon to be shown to highlight the purpose of the field
      decoration: customWidgets.whiteIconDecor(Icons.email, 'Email'),
      onChanged: (val) {
        email = val; // value entered will be stored in email
      },
    );
  }

  // widget which creates the password field
  Widget passwordField() {
    return TextFormField(
      obscureText: isObscure, // if true, the input will be obscured and not readable
      validator: (val) { // validation to make sure the password is not blank or too short
        if (val!.isEmpty) {
          return ("Enter Password");
        }
        if (val.length < 8) {
          return ("Too short");
        }
      },
      decoration: InputDecoration(
          icon: Icon( // icon to be shown to highlight the purpose of the field
            Icons.lock,
            color: Colors.white,
          ),
          hintText: "Password",
          suffixIcon: IconButton( // visibility icon ('Show password' feature)
            icon: Icon(isObscure ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(() {
                isObscure = !isObscure;
              });
            },
          )),
      onChanged: (val) {
        password = val; // value entered will be stored in password
      },
    );
  }

  // widget which creates the position field
  Widget positionField() {
    // creates a toggle button which has only two possible values
    return ToggleSwitch(
        minHeight: 50,
        minWidth: 150,
        activeBgColor: [Colors.blueAccent],
        initialLabelIndex: 0,
        totalSwitches: 2, // total number of switches
        labels: ['Student', 'Teacher'],
        onToggle: (index) {// value entered will be stored in position
          if (index == 0){
            position = 'student'; 
          }
          else{
            position = 'teacher';
          }
        });
  }

  // widget which creates the yrGroup field
  Widget yrGroupField() {
    return Row(
      children: [
        Icon(Icons.school, color: Colors.white),
        SizedBox(width: 17),
        Text("Year Group", textScaleFactor: 1.05),
        SizedBox(
          height: 10,
          width: 30,
        ),
        DropdownButton<String>(
          value: dropdownVal,
          icon: const Icon(Icons.arrow_circle_down_sharp),
          elevation: 25,
          style: const TextStyle(color: Colors.black),
          underline: Container(
            height: 2,
            color: Colors.black,
          ),
          onChanged: (String? newValue) {
            setState(() {
              dropdownVal = newValue!;
              yrGroup = newValue; // value entered will be stored in yrGroup
            });
          },
          // items to be displayed in the dropdown list
          items: <String>[
            '',
            '7',
            '8',
            '9',
            '10',
            '11',
            '12',
            '13',
            'Teacher (N/A)'
          ].map<DropdownMenuItem<String>>((String val) {
            return DropdownMenuItem<String>(
              value: val,
              child: Text(val),
            );
          }).toList(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover, // makes sure that the image takes up all the space in the container
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
                key: _formKey, // used for the
                child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 25),
                    child: Center(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                          // creating the name field using customContainer
                          customWidgets.customContainer(nameField()),
                          // creating the email field using customContainer
                          SizedBox(height: 20),
                          customWidgets.customContainer(emailField()),
                          // creating the year group dropdown list using customContainer
                          SizedBox(height: 20),
                          customWidgets.customContainer(yrGroupField()),
                          //creating the position toggle switch using customContainer
                          SizedBox(height: 20),
                          customWidgets.customContainer(positionField()),
                          SizedBox(height: 20),
                          //creating the password field using customContainer
                          customWidgets.customContainer(passwordField()),
                          SizedBox(height: 35),
                          LoginButton(
                            'Sign Up',
                            () {
                              signUp();
                            },
                          ),
                          SizedBox(height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Already made an account?  ",style: TextStyle(color: Colors.white)),
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
                                  style: constants.underlineStyle),
                                ),
                            ],
                          ),
                          SizedBox(height: 50)
                        ])))),
      ),
    );
  }
}
