import 'package:flutter/material.dart';
import '../main.dart';
import 'Authentication/welcome_screen.dart';

//import 'package:nea_prototype_1/screens/signUp_screen.dart';
class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextStyle nameStyle =
      TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white);
  TextStyle fieldStyle =
      TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black);

  Widget welcomeGreeting() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("Hi", style: TextStyle(fontSize: 14, color: Colors.white)),
      Text("${appUser.name}", style: nameStyle),
    ]);
  }

  Widget buildProfilePicture() {
    return Container(
      child: Center(
          child: ClipOval(
        child: Material(
          color: Colors.purple,
          child: Ink.image(
            alignment: Alignment.centerLeft,
            image:
                NetworkImage('https://www.woolha.com/media/2020/03/eevee.png'),
            fit: BoxFit.cover,
            width: 128,
            height: 128,
          ),
        ),
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [Colors.purple, Colors.pink],
            )),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Container(
                decoration: BoxDecoration(
                  gradient:
                      LinearGradient(colors: [Colors.purple, Colors.pink]),
                ),
                padding: EdgeInsets.all(20),
                alignment: Alignment.centerLeft,
                child: welcomeGreeting()),
          ),
        ),
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
        body: ListView(physics: BouncingScrollPhysics(), children: [
          SizedBox(
            height: 30,
          ),
          buildProfilePicture(),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
                width: 50,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(color: Color(0xFF42A5F5), spreadRadius: 3)
                    ]),
                child: Column(children: [
                  Text(
                    "Name: " + appUser.name,
                    textScaleFactor: 1.5,
                    style: fieldStyle,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Email: " + appUser.email,
                    textScaleFactor: 1.5,
                    style: fieldStyle,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Position: " + appUser.position,
                    textScaleFactor: 1.5,
                    style: fieldStyle,
                  ),
                  SizedBox(height: 20),
                  Text(
                      (appUser.position == "student")
                          ? ("Year Group: ${appUser.yearGroup}")
                          : '',
                      textScaleFactor: 1.5,
                      style: fieldStyle),
                ])),
          )
        ]));
  }
}
