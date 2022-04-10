import 'package:flutter/material.dart';
import 'package:nea_prototype_1/button.dart';
import 'package:nea_prototype_1/main.dart';
import 'package:nea_prototype_1/screens/Classes/classes_information_screen.dart';
import 'package:random_string/random_string.dart';

class ClassesScreen extends StatefulWidget {
  const ClassesScreen({Key? key}) : super(key: key);
  @override
  State<ClassesScreen> createState() => _ClassesScreenState();
}

class _ClassesScreenState extends State<ClassesScreen> {
  // controllers for all the text fields
  TextEditingController classCodeController = TextEditingController();
  TextEditingController classNameController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  // function to allow a student to add a class code
  void addClassCode(BuildContext context) async {
    // formkey used for form field validation
    final _formKey = GlobalKey<FormState>();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.blueAccent,
            title: Text('Join Class'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          // user enters class code in this field
                          controller: classCodeController,
                          validator: (val) {
                            return val!.isEmpty ? "Enter Class Code" : null;
                          },
                          decoration:
                              InputDecoration(hintText: "Enter Class Code"),
                        ),
                      ],
                    ))
              ],
            ),
            actions: [
              GenericButton("Add", () async {
                if (_formKey.currentState!.validate()) {
                  // calls a function which adds the student to the class
                  await databaseService
                      .addStudentToClass(classCodeController.text);
                  // resets the class code controller to a blank string
                  classCodeController.text = "";
                  Navigator.pop(context);
                }
              })
            ],
          );
        });
  }

  // function which creates and returns a map of all the data to be stored about a class
  Map<String, dynamic> createMap() {
    // classId is randomly generated
    String classId = randomAlphaNumeric(8);
    Map<String, dynamic> classData = {
      'classId': classId,
      'className': classNameController.text,
      'subject': subjectController.text,
      'teacherId': appUser.uid,
      'studentIds': [],
      'quizzes': []
    };
    return classData;
  }

  // function which creates a new class
  void createClass(BuildContext context) async {
    // form key used for form validation
    final _formKey = GlobalKey<FormState>();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Create Class'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          // user enters the class name
                          controller: classNameController,
                          validator: (val) {
                            return val!.isEmpty ? "Enter Class Name" : null;
                          },
                          decoration: InputDecoration(hintText: "Class Name"),
                        ),
                        TextFormField(
                          // user enters the class subject
                          controller: subjectController,
                          validator: (val) {
                            return val!.isEmpty ? "Enter Subject" : null;
                          },
                          decoration: InputDecoration(hintText: "Subject"),
                        ),
                      ],
                    ))
              ],
            ),
            actions: [
              GenericButton("Create", () async {
                if (_formKey.currentState!.validate()) {
                  // the classData map is created using the information provided by the user
                  Map<String, dynamic> classData = createMap();
                  // the new class is added to the database
                  await databaseService.addNewClassToFirebase(classData);
                  // the teachers classes are refetched
                  await databaseService.getTeacherClasses();
                  // the controllers are reset to their default value
                  classNameController.text = "";
                  subjectController.text = "";
                  Navigator.pop(context);
                }
              })
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customWidgets.customAppBar('lib/assets/classes_screen_bg.jpg',
            customWidgets.greeting('Hi', appUser.name)),
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    // background image for the body of the screen
                    fit: BoxFit.cover,
                    image: AssetImage('lib/assets/classes_screen_bg.jpg'))),
            child: Column(children: [
              Container(
                decoration: BoxDecoration(color: Colors.blue[900]),
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      (appUser.position == "student")
                          ? "Join using a class code" // students will see this text
                          : "Create a new class", // teachers will see this text
                      style: TextStyle(color: Colors.white),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        (appUser.position == "student")
                            ? addClassCode(
                                context) // this function is run if the user is student
                            : createClass(
                                context); // this function is run if the user is teacher
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Container(
                  height: 200,
                  child: ListView(scrollDirection: Axis.horizontal, children: [
                    for (int i = 0;
                        i < appUser.classes.length;
                        i++) // a clickable card will represent each of the user's classes
                      customWidgets.buildCard(context, i, appUser.classes, () {
                        databaseService.getClassQuizzes(appUser.classes[
                            i]); // the quizzes will be fetched for the current class
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ClassInfoScreen(i)));
                      } // the class info screen for the current class will be navigated to
                          ),
                  ]))
            ])));
  }
}
