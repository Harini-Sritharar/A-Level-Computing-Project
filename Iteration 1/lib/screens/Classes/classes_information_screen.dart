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
    //i is the index of the class picked in appUser.classes
    ClassDetails chosenClass = appUser.classes[widget.value];

    return Scaffold(
        appBar: customWidgets.customAppBar('lib/assets/classes_screen_bg.jpg'),
        body: Center(
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('lib/assets/classes_screen_bg.jpg')),),
                child: Column(
          children: [
            SizedBox(
              height: 35,
            ),
            customWidgets.infoCard(Icons.subject_outlined,'${chosenClass.subject}',Colors.blue[700]),
            customWidgets.infoCard(Icons.class__rounded,'Class Id : ${chosenClass.classId}',Colors.blue[700]),
            Text('Members:',style: TextStyle(fontSize: 20, color: Colors.white ),),
            Container(
                  height: 200,
                  width: 200,
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      for (int i = 0; i < chosenClass.studentNames.length; i++)
                        customWidgets.infoCard(Icons.person,'${chosenClass.studentNames[i]}',Colors.blue[500])
                    ],
                  ),
                ),
            SizedBox(height: 35),
            SizedBox(height: 50),
            

            GenericButton("Add Quiz", () {
              (appUser.position == "teacher")
                            ? addQuiz(context, chosenClass.classId)
                            : ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Student's cannot add quizzes")));
            })
          ],
        ))));
  }
}
