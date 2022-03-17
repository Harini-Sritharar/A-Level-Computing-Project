import 'package:flutter/material.dart';
import 'package:nea_prototype_1/button.dart';
import 'package:nea_prototype_1/main.dart';
import 'package:nea_prototype_1/models/class_details.dart';
import 'package:nea_prototype_1/models/quiz.dart';
//import 'package:nea_prototype_1/screens/Classes/classes_quiz_screen.dart';
import 'package:nea_prototype_1/screens/Quiz/Navigation/quiz_navigator.dart';

class ClassInfoScreen extends StatefulWidget {
  //ClassInfoScreen(int value, { Key? key }) : super(key: key);
  int value;
  ClassInfoScreen(this.value);
  @override
  State<ClassInfoScreen> createState() => _ClassInfoScreenState();
}

class _ClassInfoScreenState extends State<ClassInfoScreen> {
  String quizId = "";

  Future<void> addQuiz(BuildContext context, classId) {
    List<Quiz> userQuizzes = appUser.quizzes;
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text('Add Quiz'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 35),
                  for (int i = 0; i < (userQuizzes.length); i++)
                    TextButton(
                        onPressed: () {},
                        child: new Card(
                            child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                                leading: Icon(Icons.question_answer),
                                title: Text(userQuizzes[i].quizTitle,
                                    style: TextStyle(
                                        color: quizId == userQuizzes[i].quizId
                                            ? Colors.green
                                            : Colors.grey)),
                                onTap: () {
                                  setState(() {
                                    String _quizId = userQuizzes[i].quizId;
                                    quizId = _quizId;
                                    // print("hi");
                                  });
                                }),
                          ],
                        )))
                ],
              ),
              actions: [
                GenericButton("Add", () async {
                  await databaseService.addQuizToClass(classId, quizId);
                  Navigator.pop(context);
                })
              ],
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle myStyle2 = TextStyle(fontSize: 25, fontFamily: 'Montserrat');
    //i is the index of the class picked in appUser.classes
    ClassDetails chosenClass = appUser.classes[widget.value];
    return Scaffold(
        appBar: AppBar(
          title: Text(chosenClass.className),
          centerTitle: true,
        ),
        //floatingActionButton: FloatingActionButton(),
        body: Center(
            child: Container(
                child: Column(
          children: [
            SizedBox(
              height: 35,
            ),
            // Text("${widget.value}"),
            Text(
              "Subject: ${chosenClass.subject}",
              style: myStyle2,
              maxLines: 1,
            ),
            Text("Class Code : ${chosenClass.classId}",
                style: myStyle2, maxLines: 1),
            SizedBox(height: 35),
            Text("Members: ", style: myStyle2, maxLines: 1),
            Container(
              height: 200,
              width: 200,
              color: Colors.lightBlue,
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  for (int i = 0; i < chosenClass.studentNames.length; i++)
                    ListTile(
                      leading: Icon(Icons.school),
                      title: Text(chosenClass.studentNames[i]),
                    )
                ],
              ),
            ),
            SizedBox(height: 50),
            GenericButton("Add Quiz", () {
              addQuiz(context, chosenClass.classId);
            })

            //     Column(
            // children:[ ListView(
            //   children:  <Widget> [
            //     for (int i = 0; i < chosenClass.studentNames.length; i++)
            //       ListTile(
            //         leading: Icon(Icons.map),
            //         title: Text(chosenClass.studentNames[i]),
            //       )
            //   ],
            // ),]
            //     )
            //Text("Students ${chosenClass.studentNames}")
            //Text(chosenClass],
          ],
        ))));
  }
}
