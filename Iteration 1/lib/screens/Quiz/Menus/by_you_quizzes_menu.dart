import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nea_prototype_1/button.dart';
import 'package:nea_prototype_1/main.dart';
import 'package:nea_prototype_1/models/questionInfo.dart';
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
  //   for (var i = 0; i < appUser.quizzes.length; i++)
  //     return Card(
  //       child: Column(children: <Widget>[
  //         ListTile(
  //           title: appUser.quizzes[i]['quizTitle'],
  //           subtitle: ,)
  //       ],)
  //     );
  // }

  List<Map<String, dynamic>> userQuizzes = appUser.quizzes;
  // [
  //   // {'quizId': 'huebdjcb67', 'quizTitle': "Differentiation",},
  //   // {'quizId': 'zh2378btl', 'quizTitle': "Integration"},
  //   // {'quizId': 'zh7cgy99l', 'quizTitle': "Parametric Equations"}
  // ];

  loadInUserQuiz(){
    List<Map<String,dynamic>> questions = [];
            for (int i = 0; i < questions.length; i++){
          //QuestionInfo
        }
    // Navigator.push(context,MaterialPageRoute(builder: (context) => QuizNavigator(
    //   [

    // )))

    }
  

  // Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                     builder: (context) => QuizNavigator(
  //                       [
  //                         QuestionInfo(
  //                           "What is dy/dx of cos x?",
  //                           ["cos x", "sin x", "-sin x", "sec x"], 2 
  //                         ),
  //                         QuestionInfo(
  //                           "What is dy/dx of sin x?",
  //                           ["cosec x", "tan x", "-cos x", "cos x"], 3
  //                         ),
  //                         QuestionInfo(
  //                           "What is dy/dx of tan x?",
  //                           ["sec^2 x", "cosec^2 x", "cot x", "-sec x"], 0
  //                         ),
  //                         QuestionInfo(
  //                           "What is dy/dx of sec x?",
  //                           ["tan x", "cos x sin x", "sec x tan x", "cos x"], 2
  //                         ),
  //                       ],
  //                     ),
  // check(){
  //   for (int i = 0; i< userQuizzes.length; i++){
  //     print(Text(userQuizzes.elementAt(i)['quizTitle'].toString()),);
  //   }
  // }


onClick(){
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: 
    Text("Clicked"))
  );
}
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
                TextButton(onPressed: onClick,
                 child: new Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                       ListTile(
                        leading: Icon(Icons.question_answer),
                        title: Text(userQuizzes.elementAt(i)['quizTitle'].toString()),
                      )
                    ],
                  )
                ))
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



