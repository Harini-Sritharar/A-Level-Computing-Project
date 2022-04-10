import 'package:flutter/material.dart';
import 'package:nea_prototype_1/button.dart';
import 'package:nea_prototype_1/main.dart';
import 'package:nea_prototype_1/models/class_details.dart';
import 'package:nea_prototype_1/models/quiz.dart';
import 'package:nea_prototype_1/screens/Classes/classes_quiz_screen.dart';

class ClassInfoScreen extends StatefulWidget {
  // parameters
  final int value;
  // constructor
  ClassInfoScreen(this.value);
  @override
  State<ClassInfoScreen> createState() => _ClassInfoScreenState();
}

class _ClassInfoScreenState extends State<ClassInfoScreen> {
  // initialising quizId to an empty string
  String quizId = "";
  // function which adds a quiz to the current class
  Future<void> addQuiz(BuildContext context, classId) {
    // stores the user's quizzes in a local list so that it can be used easily
    List<Quiz> userQuizzes = appUser.quizzes;
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return AlertDialog( // returns a dialog in which the teacher can add a quiz
              title: Text('Add Quiz'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 35),
                  // show all the user's quizzes
                  for (int i = 0; i < (userQuizzes.length); i++)
                    TextButton(
                        onPressed: () {},
                        child: new Card( // returns a new card for each quiz
                            child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                                leading: Icon(
                                    Icons.question_answer), // icon of the quiz
                                title: Text(
                                    userQuizzes[i]
                                        .quizTitle, // title of the quiz
                                    style: TextStyle(
                                        color: quizId == userQuizzes[i].quizId
                                            ? Colors
                                                .green // when clicked, the card turns green
                                            : Colors
                                                .grey)), // else the card is grey
                                onTap: () { // responsible for the state of the card when clicked
                                  setState(() {
                                    String _quizId = userQuizzes[i].quizId;
                                    quizId = _quizId;
                                  });
                                }),
                          ],
                        )))
                ],
              ),
              actions: [
                GenericButton("Add", () async {
                  await databaseService.addQuizToClass(
                      classId, quizId); // adds the selected quiz to the class
                  await databaseService.getClassQuizzes(appUser.classes[widget
                      .value]); // refetches the class quizzes and updates the Class Quiz Screen
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
        appBar: customWidgets.customAppBar(
            // using a custom app bar with a background picture and text widget
            'lib/assets/classes_screen_bg.jpg',
            Text(
              '${chosenClass.className}',
              style: constants.nameStyle,
            )),
        body: Center(
            child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      // giving the container a background image
                      fit: BoxFit.cover,
                      image: AssetImage('lib/assets/classes_screen_bg.jpg')),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    customWidgets.infoCard(Icons.subject_outlined, // shows an info card which shows the subject field of the class
                        '${chosenClass.subject}', Colors.blue[700]),
                    customWidgets.infoCard(Icons.class__rounded, // shows an info card which shows the class id field of the class
                        'Class Id : ${chosenClass.classId}', Colors.blue[700]),
                    Text(
                      'Members:',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Container(
                      height: 200,
                      width: 200,
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        children: [
                          // lists all the students in the class
                          for (int i = 0;
                              i < chosenClass.studentNames.length;
                              i++)
                            customWidgets.infoCard(
                                Icons.person,
                                '${chosenClass.studentNames[i]}',
                                Colors.blue[500])
                        ],
                      ),
                    ),
                    // upon clicking the button, the class quizzes for the selected class are fetched
                    GenericButton('Quizzes', () async {
                      await databaseService
                          .getClassQuizzes(appUser.classes[widget.value]);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ClassQuizScreen(widget.value),
                          ));
                    }),
                    SizedBox(height: 35),
                    GenericButton("Add Quiz", () {
                      (appUser.position ==
                              "teacher") // this button is only clickable by teachers
                          ? addQuiz(
                              context,
                              chosenClass
                                  .classId) // the addQuiz function will be run
                          // if students click on the button, they will be shown a message in the snackbar
                          : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Students cannot add quizzes")));
                    })
                  ],
                ))));
  }
}
