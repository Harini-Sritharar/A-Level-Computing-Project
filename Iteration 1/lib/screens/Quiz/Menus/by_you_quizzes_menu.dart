import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nea_prototype_1/button.dart';
import 'package:nea_prototype_1/main.dart';
import 'package:nea_prototype_1/models/questionInfo.dart';
import 'package:nea_prototype_1/models/quiz.dart';
import 'package:nea_prototype_1/screens/Quiz/Navigation/quiz_navigator.dart';
import 'package:nea_prototype_1/services/database.dart';

class ByYouMenu extends StatefulWidget {
  ByYouMenu({
    Key? key,
  }) : super(key: key);
  @override
  _ByYouMenuState createState() => _ByYouMenuState();
}

// fetchDBList(List quizzes) async{
//   dynamic result = await databaseService.getQuizData(quizzes);
//   print(result);
//   if (result != null){
//     quizzes = result;
//     return quizzes;
//   }
//   return null;
// //
// }
class _ByYouMenuState extends State<ByYouMenu> {
  List<Quiz> userQuizzes = appUser.quizzes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("By You"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 35),
            for (int i = 0; i < (userQuizzes.length); i++)
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                QuizNavigator(userQuizzes[i].questions)));
                  },
                  child: new Card(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.question_answer),
                        title: Text(userQuizzes[i].quizTitle),
                      )
                    ],
                  )))
          ],
        ),
      ),
    );
    // return
  }
}
// class CustomCard extends StatefulWidget{
//   @override
//   Widget build(BuildContext context) {
//     return new Card(

//       child: new Column(
//         children: <Widget>[
//           new Padding(
//             padding: new EdgeInsets.all(7),
//              )
//                       ]
//                       )
//                       );
//                       }

// }
