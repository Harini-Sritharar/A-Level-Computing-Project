import 'package:flutter/material.dart';
import 'package:nea_prototype_1/main.dart';

class ScreenWidgets {
  TextStyle fieldStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white);
  TextStyle nameStyle =
      TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white);
    
  Widget welcomeGreeting() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("Hi", style: TextStyle(fontSize: 14, color: Colors.white)),
      Text("${appUser.name}", style: nameStyle),
    ]);
  }

  PreferredSizeWidget? customAppBar(imagePath){
    return AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('${imagePath}')),
                  gradient: LinearGradient(
                    colors: [Colors.blue, Colors.black, Colors.purple],
                  ))),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Container(
                decoration: BoxDecoration(),
                padding: EdgeInsets.all(20),
                alignment: Alignment.centerLeft,
                child: screenWidgets.welcomeGreeting()),
          ),
        );
  }


  Widget infoCard(icon, title, color) {
    return Card(
      color: color,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: ListTile(
          leading: Icon(icon),
          title: Text("$title",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white))),
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
                    Text('Created ${appUser.quizzes.length} ',
                        style: fieldStyle),
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
          screenWidgets.infoCard(
              Icons.person, appUser.position, Colors.blue[700]),
          screenWidgets.infoCard(
              Icons.email_outlined, appUser.email, Colors.blue[700]),
          screenWidgets.infoCard(
              Icons.school, "Year " + appUser.yearGroup, Colors.blue[700])
        ]);
  }
}
