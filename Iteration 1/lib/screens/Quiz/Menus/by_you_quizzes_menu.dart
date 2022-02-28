import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nea_prototype_1/button.dart';
import 'package:nea_prototype_1/main.dart';
import 'package:nea_prototype_1/screens/Quiz/Navigation/questionInfo.dart';
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

  List<Map<String, String>> quizzes = [
    {'quizId': 'huebdjcb67', 'quizTitle': "Testing"},
    {'quizId': 'zh2378btl', 'quizTitle': "Testing 2"},
    {'quizId': 'zh2378btl', 'quizTitle': "Testing 2"}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 35)
,            for (int i = 0; i < (quizzes.length); i++)
              Container(
                  padding: EdgeInsets.all(50),
                  decoration: BoxDecoration(
                      color: Colors.teal[20],
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: [
                        BoxShadow(color: Color(0xFF42A5F5), spreadRadius: 3)
                      ]),
                  child: Column(
                    children: [
                      SizedBox(),
                      Text(quizzes.elementAt(i)['quizTitle'].toString()
                      ),
                    ],
                  ),
                  ),
                  SizedBox(height: 35),

          ],
        ),
      ),
    );
    // return
  }
} 



