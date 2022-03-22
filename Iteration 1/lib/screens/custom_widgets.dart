import 'package:flutter/material.dart';
import 'package:nea_prototype_1/main.dart';

class CustomWidgets {
  
  Widget welcomeGreeting() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("Hi", style: TextStyle(fontSize: 14, color: Colors.white)),
      Text("${appUser.name}", style: constants.nameStyle),
    ]);
  }
  // creates a custom app bar
  PreferredSizeWidget? customAppBar(imagePath) {
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover, image: AssetImage('$imagePath')),
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.black, Colors.purple],
              ))),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            child: customWidgets.welcomeGreeting()),
      ),
    );
  }
  // creates an information card for use in the Profile Screen
  Widget infoCard(icon, title, color) {
    return Card(
      color: color,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: ListTile(
          leading: Icon(icon),
          title: Text("$title", style: constants.fieldStyle)),
    );
  }
  // creates a divider
  Widget divider() {
    return Container(color: Colors.white, height: 30, width: 0.2);
  }
  // creates the widget on the Profile Screen with user statistics
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
                    '${appUser.name}',
                    style: constants.nameStyle,
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
                    Text('Joined in', style: constants.fieldStyle),
                    Text('3/2022', style: constants.fieldStyle)
                  ],
                ),
                divider(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Created ${appUser.quizzes.length} ',
                        style: constants.fieldStyle),
                    Text('Quizzes', style: constants.fieldStyle)
                  ],
                ),
                divider(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Joined ${appUser.classes.length}',
                        style: constants.fieldStyle),
                    Text('Classes', style: constants.fieldStyle)
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 35),
          // info cards
          customWidgets.infoCard(
              Icons.person, appUser.position, constants.defaultCardColour),
          customWidgets.infoCard(
              Icons.email_outlined, appUser.email, constants.defaultCardColour),
          customWidgets.infoCard(Icons.school, "Year " + appUser.yearGroup,
              constants.defaultCardColour)
        ]);
  }
  // Custom Container widget
  Widget customContainer(child) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            color: constants.defaultBlueColour,
            borderRadius: BorderRadius.circular(30)),
        child: child);
  }
}