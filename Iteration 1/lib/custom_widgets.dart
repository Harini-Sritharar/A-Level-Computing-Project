import 'package:flutter/material.dart';
import 'package:nea_prototype_1/main.dart';
import 'package:nea_prototype_1/models/quiz.dart';
import 'package:nea_prototype_1/screens/Quiz/Navigation/quiz_navigator.dart';

class CustomWidgets {
  // function which creates a greeting using the two parameters provided
  Widget greeting(line1, line2) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("$line1", style: TextStyle(fontSize: 14, color: Colors.white)), // this text is bigger than the next line of text
      Text("$line2", style: constants.nameStyle),
    ]);
  }

  // creates a custom app bar
  PreferredSizeWidget? customAppBar([imagePath, child]) {
    return AppBar(
        centerTitle: true, // the title is centered
        automaticallyImplyLeading: false, // removes the back button from the app bar
        flexibleSpace: Container(
            decoration: BoxDecoration(
          image: DecorationImage( // uses the Asset Image as the background image
              fit: BoxFit.cover, image: AssetImage('$imagePath')),
        )),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Container(
              padding: EdgeInsets.all(20),
              alignment: Alignment.centerLeft, // the child is aligned in the center left of the container
              child: child),
        ));
  }

  // creates an information card for use in the Profile Screen
  Widget infoCard(icon, title, color) {
    return Card(
      color: color,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: ListTile(
          leading: Icon(icon), // the icon is shown to the left of the text below
          title: Text("$title", style: constants.fieldStyle)),
    );
  }

  // creates a divider
  Widget divider() {
    // creates a container with a very small width
    return Container(color: Colors.white, height: 30, width: 0.2);
  }

  // creates the widget on the Profile Screen with user statistics
  Widget buildInfo() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,// aligned at the start of this axis
        crossAxisAlignment: CrossAxisAlignment.center, // aligned at the centre of this axis
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 15),
              // building the profile picture
              child: CircleAvatar(// creates a profile picture using the default image
                  radius: 60,
                  backgroundImage: AssetImage('lib/assets/minion.webp')),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20), // padding for the column
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // adding user's name to the Profile Screen
                  Text(
                    '${appUser.name}', // shows the user's name in line with the Circle Avatar
                    style: constants.nameStyle,
                  ),
                ],
              ),
            ),
          ]),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // all widgets in this row are evenly spaced out
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // shows the date the user has joined in
                    Text('Joined in', style: constants.fieldStyle),
                    Text('3/2022', style: constants.fieldStyle)
                  ],
                ),
                divider(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // shows how many quizzes the user has created
                    Text('Created ${appUser.quizzes.length} ',
                        style: constants.fieldStyle),
                    Text('Quizzes', style: constants.fieldStyle)
                  ],
                ),
                divider(),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // shows how many class the user has joined/created
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
              Icons.person, appUser.position, constants.defaultCardColour),// shows the user's position
          customWidgets.infoCard(
              Icons.email_outlined, appUser.email, constants.defaultCardColour),// shows the user's email
          customWidgets.infoCard(Icons.school, "Year " + appUser.yearGroup,
              constants.defaultCardColour)// shows the user's year group
        ]);
  }

  // Custom Container widget
  Widget customContainer(child) {
    return Column(
      children: [
        Container(
            width: 500,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                color: constants.defaultBlueColour,
                borderRadius: BorderRadius.circular(30)),
            child: child // child of the container is the child passed in as the parameter
            ),
        SizedBox(height: 10)
      ],
    );
  }
  // returns an white icon with the specified hint text
  InputDecoration whiteIconDecor(IconData icon, [String? hint]) {
    return InputDecoration(
      icon: Icon(icon, color: Colors.white),
      hintText: "Your $hint",
    );
  }
  // creates a clickable card widget
  Widget createCard(i, BuildContext context, List<Quiz> quizzes) {
    return GestureDetector(
      child: Container(
        height: 200,
        width: 200,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(colors: [Colors.purple, Colors.teal])),// creates a linear gradient for this container
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // aligned at the centre of this axis
            children: [
              Column(
                children: [
                  Icon(Icons.quiz_outlined), // shows the quiz icon
                  Text(quizzes[i].quizTitle, // shows the quizTitle if the quiz in the list quizzes at the index i provided
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                          fontSize: 20))
                ],
              )
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => QuizNavigator(quizzes[i].questions)));// navigates the user to the quiz screen of the selected quiz
      },
    );
  }
  // creates a card which shows the information provided as parameters
  Widget buildCard(BuildContext context, int i, List cardItem, onTap) {
    return GestureDetector( // onTap function is run when the gesture detector is pressed
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(colors: [ // gives the Container a gradient background
                Colors.blueAccent,
                Colors.blue,
                Colors.lightBlueAccent
              ])),
          margin: EdgeInsets.symmetric(horizontal: 5),
          width: 200,
          height: 200,
          child: Center(
              child: Column(
            children: [
              Spacer(),
              Text(cardItem[i].className, style: constants.nameStyle),// specifies the className of the class provided
              Text(cardItem[i].subject, style: constants.fieldStyle),// specifies the subject of the class provided
              Spacer(),
            ],
          )),
        ),
        onTap: onTap // calls the onTap function provided as a parameter
        );
  }
}
