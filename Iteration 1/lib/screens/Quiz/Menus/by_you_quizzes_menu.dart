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
    {'quizId': 'huebdjcb67', 'quizTitle': "Differentiation"},
    {'quizId': 'zh2378btl', 'quizTitle': "Integration"},
    {'quizId': 'zh7cgy99l', 'quizTitle': "Parametric Equations"}
  ];

onClick(){
  return null;
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
            for (int i = 0; i < (quizzes.length); i++)
                TextButton(onPressed: onClick,
                 child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                       ListTile(
                        leading: Icon(Icons.question_answer),
                        title: Text(quizzes.elementAt(i)['quizTitle'].toString()),
                        

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



