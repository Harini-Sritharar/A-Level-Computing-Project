import 'package:flutter/material.dart';
import 'package:nea_prototype_1/main.dart';
import 'package:nea_prototype_1/models/quiz.dart';
import 'package:nea_prototype_1/screens/Quiz/Navigation/quiz_navigator.dart';
import 'package:random_string/random_string.dart';

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
                  image: AssetImage('lib/assets/by_you_screen_bg.jpg'))),
      
      child: Scaffold(
        backgroundColor: Colors.transparent,
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
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  ),
                children:  [
                      for (int i = 0; i < appUser.quizzes.length; i++) 
                      customWidgets.createCard(i,context,appUser.quizzes),
                ],
              ),
              ),
          ),
          ),
    );
  }
}
