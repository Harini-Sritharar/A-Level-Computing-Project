import 'package:flutter/material.dart';
import 'package:nea_prototype_1/button.dart';
import 'package:nea_prototype_1/models/user_details.dart';
import 'package:nea_prototype_1/screens/BottomNavBar/bottom_nav_bar.dart';
import '../../main.dart';
import 'signUp_screen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  // form key is used for form field validation
  final _formKey = GlobalKey<FormState>();
  // initialising variables to default values
  late String email, password;
  bool isObscure = true; // represents the visibility of the password field
  bool _isLoading =
      false; // represents the loading state of the progress indicator

  // function which signs in the user using the user details provided on the screen
  Future<void> signIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
// whilst the following lines of code are run, the progress indicator will be running to show the user their input is being processed
      });
      _isLoading = true;
      // the newUser is set to the user whose details have been provided on this screen
      UserDetails? newUser = await authService.signInEmailAndPassword(email,password); 
      if (newUser == null) {
        // if the details provided do not link to a user in the database, the user is redirected to the Welcome Screen
        _isLoading = true;
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => WelcomeScreen(),
            ));
        return null;
      }
      appUser = newUser; // if the user does exist in the database
      await appUser
          .initialise(); // fetches all the information required about the user
      setState(() {
        _isLoading = true;
      });
      _isLoading = false;
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                BottomNavBar(), // user navigated to the bottom navigation bar which takes them to the Profile page
          ));
    }
  }

  // Text Form Field responsible for obtaining the email
  Widget emailField() {
    return TextFormField(
      validator: (val) {
        // validation, does not allow the user to proceed if email is empty or invalid
        return (val!.isEmpty || !val.contains('@'))
            ? "⚠️ Enter a valid email address"
            : null;
      },
      decoration: customWidgets.whiteIconDecor(
          Icons.email, 'Email'), // creates a custom icons for the field
      onChanged: (val) {
        email = val; // assigns the input to the email variable
      },
    );
  }

  // Text Form Field responsible for obtaining the password
  Widget passwordField() {
    return TextFormField(
      obscureText: isObscure,
      validator: (val) {
        // validation for the field, does not allow the user to proceed if password is empty
        return val!.isEmpty ? "⚠️ Enter Password" : null;
      },
      decoration: InputDecoration(
          icon: Icon(Icons.lock,color: Colors.white,
          ),
          hintText: "Your Password",
          suffixIcon: IconButton(
            // allows the user to change the visibility of the input in the field
            icon: Icon(isObscure ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(() {
                // when pressed once, the text will be visible, when pressed again, it will be hidden
                isObscure = !isObscure;
              });
            },
          )),
      onChanged: (val) {
        password = val; // assigns the input to the password variable
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('lib/assets/welcome_screen_bg.jpg')), // background image for the screen
        ),
        child: Scaffold(
            backgroundColor: Colors.transparent, // required in order for the background image to be visible
            // when loading the Progress Indicator will run, after loading, it wil go to the form
            body: Container(
                child: _isLoading ? Container(child: Center(
                        child: CircularProgressIndicator(),
                      ))
                    : Form(
                        key: _formKey,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 25),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center, // all widgets are aligned in the centre of both axes
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                customWidgets.customContainer(emailField()), // customWidgets provides a custom container for the emailField
                                SizedBox(height: 20),
                                customWidgets.customContainer(passwordField()), //customWidgets provides a custom container for the passwordField
                                SizedBox(height: 35),
                                LoginButton("Login",() async {await signIn();} // signIn function is run when the LoginButton is clicked
                                ),
                                SizedBox(height: 35),
                                // the following code allows the user to navigate to the Sign Up Screen to create a new account
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
                                                    SignUpScreen())); // navigates the user to the Sign Up Screen
                                      },
                                      child: Text("Sign Up", style: constants.underlineStyle),
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
