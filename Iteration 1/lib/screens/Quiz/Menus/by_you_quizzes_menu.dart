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

// addToClass(BuildContext context) {
//   final _formKey = GlobalKey<FormState>();
//   return showDialog(
//       context: context,
//       builder: (context) {
//         var subjectController;
//         return AlertDialog(
//           title: Text('Add Quiz'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Form(
//                   key: _formKey,
//                   child: Column(
//                     children: [
//                       TextFormField(
//                         controller: subjectController,
//                         validator: (val) {
//                           return val!.isEmpty ? "Subject" : null;
//                         },
//                         decoration: InputDecoration(hintText: "Subject"),
//                       ),
//                     ],
//                   ))
//             ],
//           ),
//           actions: [],
//         );
//       });
// }

class _ByYouMenuState extends State<ByYouMenu> {
  Widget createCard(i) {
    return GestureDetector(
      child: Container(
        height: 200,
        width: 200,
        //width: 150,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.purple[100], borderRadius: BorderRadius.circular(16) ),
          margin: EdgeInsets.symmetric(horizontal: 5),

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
  // Widget buildCard(int i) {
  //   int value = i;
  //   return GestureDetector(
  //     child: Container(
  //       color: Colors.red,
  //       margin: EdgeInsets.symmetric(horizontal: 5),
  //       width: 200,
  //       height: 200,
  //       child: Center(
  //           child: Column(
  //         children: [
  //           Spacer(),
  //           Text(appUser.classes[i].className),
  //           Text(appUser.classes[i].subject),
  //           Spacer(),
  //         ],
  //       )),
  //     ),
  //     onTap:(){
  //     Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                     builder: (context) =>  ClassInfoScreen(value)));}
  //   );
  // }

  List<Quiz> userQuizzes = appUser.quizzes;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("By You"),
          centerTitle: true,
        ),
        body: Container(
          height: 200,

          child: ListView(
            scrollDirection: Axis.horizontal,
            children:  [
                  //Spacer(),
                  for (int i = 0; i < appUser.quizzes.length; i++) createCard(i),
                  //Spacer()
            ],
          ),
        )






        
        // ListView(
        //         scrollDirection: Axis.horizontal,
        //         children: [
        //           Container(
        //             height: 500,
        //             child: GridView(
        //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //             crossAxisCount: 2,
        //             crossAxisSpacing: 10,
        //             mainAxisSpacing: 10),
        //         children: [
        //           for (int i = 0; i < userQuizzes.length; i++)
        //           createCard(i),
        //           Text("i"),

        //           //QuizCard.createCard(i: i)
        //         ],
        //       ),
        //     )
        //          // for (int i = 0; i < appUser.classes.length; i++) createCard(i)
        //         ],
        //       ),
        // // body: ListView(
        //   physics: BouncingScrollPhysics(),
        //   padding: const EdgeInsets.all(15),
        //   children: [
        //     SizedBox(height: 10),
        //     Container(
        //       height: 500,
        //       child: GridView(
        //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //             crossAxisCount: 2,
        //             crossAxisSpacing: 10,
        //             mainAxisSpacing: 10),
        //         children: [
        //           for (int i = 0; i < userQuizzes.length; i++) createCard(i),
        //           //QuizCard.createCard(i: i)
        //         ],
        //       ),
        //     )
        //   ],
        // )

        // body: Center(
        //   child: Column(
        //     children: [
        //       SizedBox(height: 35),

        //       for (int i = 0; i < (userQuizzes.length); i++)
        //         TextButton(
        //             onPressed: () {
        //               Navigator.push(
        //                   context,
        //                   MaterialPageRoute(
        //                       builder: (context) =>
        //                           QuizNavigator(userQuizzes[i].questions)));
        //             },
        //             //child:
        //             child: new Card(
        //                 child: Column(
        //               mainAxisSize: MainAxisSize.min,
        //               children: <Widget>[
        //                 ListTile(
        //                   leading: Icon(Icons.question_answer),
        //                   title: Text(userQuizzes[i].quizTitle),
        //                   //onLongPress: addToClass(context),
        //                   onLongPress: () {
        //                     Navigator.push(
        //                         context,
        //                         MaterialPageRoute(
        //                             builder: (context) =>
        //                                 QuizNavigator(userQuizzes[i].questions)));
        //                   },
        //                 ),
        //                 // Row(
        //                 //   children: [
        //                 //     Icon(Icons.question_answer),
        //                 //     Text(userQuizzes[i].quizTitle,
        //                 //     ),
        //                 //     SizedBox(width: 50,),
        //                 // GestureDetector(
        //                 //   child: Icon(Icons.add)
        //                 // )],)
        //               ],
        //             )))
        //     ],
        //   ),
        // ),
        );
    // return
  }
}
