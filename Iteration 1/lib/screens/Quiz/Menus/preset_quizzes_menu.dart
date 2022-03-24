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
                  fit: BoxFit.cover,
                  image: AssetImage('lib/assets/preset_quizzes_screen_bg.jpg'))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text("Pre Set Quizzes"),
          centerTitle: true,
        ),
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              gradient:LinearGradient(colors: [Colors.teal,Colors.blue] ),),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                for (int i = 0; i < appUser.presetQuizzes.length; i++)
                customWidgets.createCard(i, context,appUser.presetQuizzes),
                SizedBox(height: 35),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
