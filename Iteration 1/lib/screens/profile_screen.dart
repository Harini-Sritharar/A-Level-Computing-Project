import 'package:flutter/material.dart';
import 'package:nea_prototype_1/button.dart';
import 'package:nea_prototype_1/screens/Walkthrough/walkthrough.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import '../main.dart';
import 'Authentication/welcome_screen.dart';
class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}
class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floating action button for sign out
        floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await authService.signOut();// signOut function run from the AuthService class
              Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => WelcomeScreen(),// all screens are popped off the stack until the Welcome Screen is reached
                  ),
                  (route) => false);
            },
            child: const Icon(Icons.logout)),// a logout icon is shown on the Floating Action Button
        body: Container(
          decoration: BoxDecoration(
              color: Colors.blue[900], // default background colour in case the image does not load
              image: DecorationImage(
                  fit: BoxFit.cover, // ensures that the image takes up the entire screen
                  image: AssetImage('lib/assets/profile_screen_bg.jpeg'))),// background image for the screen
          child: ListView(
            physics: BouncingScrollPhysics(),// ensures that the container bounces back from the edge
           children: <Widget>[
            SizedBox(height: 30),
            customWidgets.buildInfo(), // function which builds all the info widgets on the screen
            SizedBox(height: 20), 
            // cirlce button which leads the user to the Walkthrough
            CircleButton('Walkthrough', () {
              pushNewScreenWithRouteSettings(context,
                  screen: WalkthroughScreen(),
                  settings: RouteSettings(),
                  withNavBar: false);// the navigation bar is not shown on the Walkthrough screen
            })
          ]),
        ));
  }
}
