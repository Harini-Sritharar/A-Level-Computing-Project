import 'package:flutter/material.dart';
import 'package:nea_prototype_1/screens/screen_widgets.dart';
import '../main.dart';
import 'Authentication/welcome_screen.dart';

//import 'package:nea_prototype_1/screens/signUp_screen.dart';
class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await authService.signOut();
              Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => WelcomeScreen(),
                  ),
                  (route) => false);
            },
            child: const Icon(Icons.logout)),
        body: Container(
          decoration: BoxDecoration(
              color: Colors.blue[900],
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('lib/assets/profile_screen_bg.jpeg'))),
          child: ListView(physics: BouncingScrollPhysics(), children: <Widget>[
            SizedBox(height: 30),
            screenWidgets.buildInfo(),
            SizedBox(height: 20),
          ]),
        ));
  }
}
