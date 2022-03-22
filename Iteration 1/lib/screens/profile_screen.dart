import 'package:flutter/material.dart';
import 'package:nea_prototype_1/button.dart';
import 'package:nea_prototype_1/custom_widgets.dart';
import 'package:nea_prototype_1/screens/Walkthrough/walkthrough.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
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
            customWidgets.buildInfo(),
            SizedBox(height: 20),
            CircleButton('Tutorial', () {
              pushNewScreenWithRouteSettings(context,
                  screen: WalkthroughScreen(),
                  settings: RouteSettings(),
                  withNavBar: false);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WalkthroughScreen(),
                  ));
            })
          ]),
        ));
  }
}
