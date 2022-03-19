import 'package:flutter/material.dart';
import 'package:nea_prototype_1/button.dart';
import 'package:nea_prototype_1/models/user_details.dart';
import 'package:nea_prototype_1/screens/BottomNavBar/bottom_nav_bar.dart';
import 'package:nea_prototype_1/services/auth.dart';
import '../../main.dart';
import 'signUp_screen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  

  final _formKey = GlobalKey<FormState>();
  late String email, password;
  // fixed late initialiseation error by giving email and password default vallues of empty strings.
  AuthService authService = new AuthService();
  bool _isLoading = false;

  Future<void> signIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      // email = 'student@gmail.com';
      // password = 'student';
      UserDetails? newUser =
          await authService.signInEmailAndPassword(email, password);
      if (newUser == null) {
        print("Null");
        _isLoading = true;
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => WelcomeScreen(),
            ));
        return null;
      }
      appUser = newUser;
      await appUser.initialise();
      setState(() {
        _isLoading = true;
      });
      _isLoading = false;
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BottomNavBar(),
          ));
    }
  }

  Widget emailField() {
    return TextFormField(
      validator: (val) {
        return val!.isEmpty ? "⚠️ Enter Email" : null;
      },
      decoration: InputDecoration(
        icon: Icon(
          Icons.email,
          color: Colors.white,
        ),
        hintText: "Your Email",
      ),
      onChanged: (val) {
        email = val;
      },
    );
  }

  Widget passwordField() {
    return TextFormField(
      obscureText: isObscure,
      validator: (val) {
        return val!.isEmpty ? "⚠️ Enter Password" : null;
      },
      decoration: InputDecoration(
          icon: Icon(
            Icons.password,
            color: Colors.white,
          ),
          hintText: "Your Password",
          suffixIcon: IconButton(
            icon: Icon(isObscure ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(() {
                isObscure = !isObscure;
              });
            },
          )),
      onChanged: (val) {
        password = val;
      },
    );
  }

  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('lib/assets/welcome_screen_bg.jpg')),
        ),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            // when loading the Progress Indicator will run, after loading, it wil go to the form
            body: Container(
                child: _isLoading
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
                                screenWidgets.customContainer(emailField()),
                                SizedBox(height: 20),
                                screenWidgets.customContainer(passwordField()),
                                SizedBox(height: 35),
                                LoginButton(
                                  "Login",
                                  () async {
                                    await signIn();
                                  },
                                ),
                                SizedBox(height: 35),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "No account yet?  ",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SignUpScreen()));
                                      },
                                      child: Text("Sign Up",
                                          style: constants.underlineStyle),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ))));
  }
}
