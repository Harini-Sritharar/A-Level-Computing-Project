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
  Widget createCard(i) {
    return GestureDetector(
      child: Container(
        height: 200,
        width: 200,
        //width: 150,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            //color: Colors.purple[100],
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [Colors.purple,Colors.teal]) ),
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                    Icon(Icons.quiz_outlined),
                    Text(appUser.quizzes[i].quizTitle)
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => QuizNavigator(userQuizzes[i].questions)));
      },
    );
  }
  List<Quiz> userQuizzes = appUser.quizzes;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          height: 400,
          child: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              ),
            children:  [
                  //Spacer(),
                  for (int i = 0; i < appUser.quizzes.length; i++) createCard(i),
                  //Spacer()
            ],
          ),
      
            
          ),
        );
  }
}
