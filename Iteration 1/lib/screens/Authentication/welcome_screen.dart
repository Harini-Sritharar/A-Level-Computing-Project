import 'package:flutter/material.dart';
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
  late String email = '', password = '';
  TextStyle myStyle = TextStyle(color: Colors.white12);
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
        _isLoading = false;
      });
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BottomNavBar(),
          ));
    }
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
                                screenWidgets.textFormFieldContainer(
                                    Icons.email,
                                    'Email',
                                    email,
                                    Colors.cyan[300],
                                    null),
                                SizedBox(height: 20),
                                screenWidgets.textFormFieldContainer(
                                    Icons.password,
                                    'Password',
                                    password,
                                    Colors.cyan[300],
                                    IconButton(
                                      icon: Icon(isObscure
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                      onPressed: () {
                                        setState(() {
                                          isObscure = !isObscure;
                                        });
                                      },
                                    )),
                                SizedBox(height: 35),
                                GestureDetector(
                                    onTap: () async {
                                      await signIn();
                                    },
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 20),
                                      decoration: BoxDecoration(
                                          color: Colors.cyan[400],
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      alignment: Alignment.center,
                                      width: MediaQuery.of(context).size.width -
                                          40,
                                      child: Text("Login",style: TextStyle(
                                        color: Colors.white,fontSize: 20, fontWeight: FontWeight.bold
                                      )),
                                    )),
                                SizedBox(height: 35),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("No account yet?  ", style: TextStyle(color: Colors.white),),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SignUpScreen()));
                                      },
                                      child: Text(
                                        "Sign Up",
                                        style: TextStyle(
                                          color: Colors.white,
                                          decoration: TextDecoration.underline
                                        )
                                        ),
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
