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
  String url = 'https://www.artofit.org/image-gallery/156781630767765650/';
  TextStyle nameStyle =
      TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white);
  TextStyle fieldStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white);

  Widget welcomeGreeting() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("Hi", style: TextStyle(fontSize: 14, color: Colors.white)),
      Text("${appUser.name}", style: nameStyle),
    ]);
  }

  Widget infoCard(icon, title) {
    return Card(
      color: Colors.blue,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: ListTile(
          leading: Icon(icon), title: Text("$title", style: fieldStyle)),
    );
  }

  Widget buildInfo() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 15),
              // building the profile picture
              child: CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(
                    'https://www.woolha.com/media/2020/03/eevee.png'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // adding user's name
                  Text(
                    'Harini Sritharar',
                    style: nameStyle,
                  ),
                ],
              ),
            ),
          ]),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Joined in', style: fieldStyle),
                    Text('3/2022', style: fieldStyle)
                  ],
                ),
                Container(color: Colors.white, height: 30, width: 0.2),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Created ${appUser.quizzes.length} ', style: fieldStyle),
                    Text('Quizzes', style: fieldStyle)

                  ],
                ),
                Container(color: Colors.white, height: 30, width: 0.2),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Joined ${appUser.classes.length}', style: fieldStyle),
                    Text('Classes', style: fieldStyle)
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 35),
          // info cards
          infoCard(Icons.person, appUser.position),
          infoCard(Icons.email_outlined, appUser.email),
          infoCard(Icons.school,"Year " + appUser.yearGroup)


        ]);
    //child: ClipOval(
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   centerTitle: true,
        //   automaticallyImplyLeading: true,
        //   flexibleSpace: Container(
        //     decoration: BoxDecoration(
        //         gradient: LinearGradient(
        //       colors: [Colors.purple, Colors.pink],
        //     )),
        //   ),
        //   bottom: PreferredSize(
        //     preferredSize: Size.fromHeight(50),
        //     child: Container(
        //         decoration: BoxDecoration(
        //           gradient:
        //               LinearGradient(colors: [Colors.purple, Colors.pink]),
        //         ),
        //         padding: EdgeInsets.all(20),
        //         alignment: Alignment.centerLeft,
        //         child: welcomeGreeting()),
        //   ),
        // ),
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
            buildInfo(),
            SizedBox(height: 20),
            

            // Padding(
            //   padding: const EdgeInsets.all(10),
            //   child: Container(
            //       width: 50,
            //       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            //       decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(40),
            //           boxShadow: [
            //             BoxShadow(color: Color(0xFF42A5F5), spreadRadius: 3)
            //           ]),
            //       child: Column(children: [
            //         Text(
            //           "Name: " + appUser.name,
            //           textScaleFactor: 1.5,
            //           style: fieldStyle,
            //         ),
            //         SizedBox(height: 20),
            //         Text(
            //           "Email: " + appUser.email,
            //           textScaleFactor: 1.5,
            //           style: fieldStyle,
            //         ),
            //         SizedBox(height: 20),
            //         Text(
            //           "Position: " + appUser.position,
            //           textScaleFactor: 1.5,
            //           style: fieldStyle,
            //         ),
            //         SizedBox(height: 20),
            //         Text(
            //             (appUser.position == "student")
            //                 ? ("Year Group: ${appUser.yearGroup}")
            //                 : '',
            //             textScaleFactor: 1.5,
            //             style: fieldStyle),
            //       ])),
            // )
          ]),
        ));
  }
}
