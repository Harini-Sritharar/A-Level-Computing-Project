import 'package:flutter/material.dart';
import 'package:nea_prototype_1/button.dart';
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
    //final String initial = appUser.name[0];
    TextStyle myStyle = TextStyle(color: Colors.white);
    //name = myController.text;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(appUser.name + "'s Profile"),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 45.0),
            CircleAvatar(
              backgroundImage: NetworkImage('https://www.woolha.com/media/2020/03/eevee.png'),
              //backgroundImage: NetworkImage("https:pngtree.com/freepng/flat-user-avatar-astronaut_4720959.html"),
              radius: 50,
            ),
            SizedBox(height:20),         
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color:Colors.teal[20],
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                  color: Color(0xFF42A5F5), spreadRadius: 3
                  )]),    
              child: Column(
                children: [
            Text(
              "Name: " + appUser.name,
              textScaleFactor: 1.5,
              style: myStyle,
            ),
            SizedBox(height:20),         
            Text(
              "Email: " + appUser.email,
              textScaleFactor: 1.5,
              style: myStyle,
            ),
           
            SizedBox(height:20),         
            Text(
              "Position: " + appUser.position,
              textScaleFactor: 1.5,
              style: myStyle,
            ),
            SizedBox(height:20),
            
            Text((appUser.position == "student")
                      ? ("Year Group: ${appUser.yearGroup}") : '',
             textScaleFactor: 1.5,
              style: myStyle),
            ]
            )),
            SizedBox(height:200),
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
            onPressed: ()  async {await authService.signOut();
                Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => WelcomeScreen(),
                    ),
                    (route) => false);
            },
            child: const Icon(Icons.logout))
            )
          ])
      ),
    );
  }
}
