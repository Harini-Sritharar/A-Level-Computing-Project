import 'package:flutter/material.dart';
import 'package:nea_prototype_1/main.dart';

class PresetMenu extends StatelessWidget {
  PresetMenu({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              // ensures that the background image takes up all the space in the container
              fit: BoxFit.cover, 
               // background image for this screen
              image: AssetImage('lib/assets/preset_quizzes_screen_bg.jpg'))),
      child: Scaffold(
        backgroundColor: Colors.transparent,// background colour must be transparent for the background image to be visible
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text("Pre Set Quizzes"),
          centerTitle: true,
        ),
        body: Container(
          child: Container(
              height: 500,
              // creates a vertically scrollable list of widgets
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                children: <Widget>[
                  // iterates through all the preset quizzes available to the user
                  for (int i = 0; i < appUser.presetQuizzes.length; i++)
                  // a custom widget is created for each quiz
                    customWidgets.createCard(i, context, appUser.presetQuizzes),
                  SizedBox(height: 35),
                ],
              )),
        ),
      ),
    );
  }
}
