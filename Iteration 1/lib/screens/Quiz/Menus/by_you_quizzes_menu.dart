import 'package:flutter/material.dart';
import 'package:nea_prototype_1/main.dart';
class ByYouMenu extends StatefulWidget {
  ByYouMenu({
    Key? key,
  }) : super(key: key);
  @override
  _ByYouMenuState createState() => _ByYouMenuState();
}
class _ByYouMenuState extends State<ByYouMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('lib/assets/by_you_screen_bg.jpg'))), // background image for this screen
      
      child: Scaffold(
        backgroundColor: Colors.transparent, // background colour must be transparent for the background image to be visible
          appBar: AppBar(
            title: Text("By You"),
            centerTitle: true,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple,Colors.blue],
                )
          ),
            )),
          body: Container(
            child: Container(
              height: 400,
              // creates a vertically scrollable list of widgets
              child: GridView( 
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  ),
                children:  [
                      for (int i = 0; i < appUser.quizzes.length; i++) 
                      customWidgets.createCard(i,context,appUser.quizzes),// a custom widget is created for each quiz
                ],
              ),
              ),
          ),
          ),
    );
  }
}
