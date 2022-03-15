import 'package:flutter/material.dart';
import 'package:nea_prototype_1/button.dart';
import 'package:nea_prototype_1/main.dart';
import 'package:nea_prototype_1/screens/classes_information_screen.dart';
import 'package:random_string/random_string.dart';

class ClassesScreen extends StatefulWidget {
  const ClassesScreen({Key? key}) : super(key: key);

  @override
  State<ClassesScreen> createState() => _ClassesScreenState();
}

class _ClassesScreenState extends State<ClassesScreen> {
  TextEditingController classCodeController = TextEditingController();
  TextEditingController classNameController = TextEditingController();
  TextEditingController subjectController = TextEditingController();

  Widget buildCard(int i) {
    int value = i;
    return GestureDetector(
      child: Container(
        color: Colors.red,
        margin: EdgeInsets.symmetric(horizontal: 5),
        width: 200,
        height: 200,
        child: Center(
            child: Column(
          children: [
            Spacer(),
            Text(appUser.classes[i].className),
            Text(appUser.classes[i].subject),
            Spacer(),
          ],
        )),
      ),
      onTap:(){
      Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  ClassInfoScreen(value)));}
    );
  }

  void addClassCode(BuildContext context) async {
    final _formKey = GlobalKey<FormState>();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Join Class'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
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
              GenericButton("Add", () {
                if (_formKey.currentState!.validate()) {
                  databaseService.addStudentToClass(classCodeController.text);
                  classCodeController.text = "";
                  Navigator.pop(context);
                }
              })
            ],
          );
        });
  }

  Map<String, dynamic> createMap() {
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

  void createClass(BuildContext context) async {
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
                          controller: classNameController,
                          validator: (val) {
                            return val!.isEmpty ? "Class Name" : null;
                          },
                          decoration: InputDecoration(hintText: "Class Name"),
                        ),
                        TextFormField(
                          controller: subjectController,
                          validator: (val) {
                            return val!.isEmpty ? "Subject" : null;
                          },
                          decoration: InputDecoration(hintText: "Subject"),
                        ),
                      ],
                    ))
              ],
            ),
            actions: [
              GenericButton("Create", () {
                if (_formKey.currentState!.validate()) {
                  Map<String, dynamic> classData = createMap();
                  databaseService.addNewClassToFirebase(classData);
                  databaseService.getTeacherClasses();
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
        appBar: AppBar(
          title: Text("Classes"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text((appUser.position == "student")
                      ? "Join using a class code"
                      : "Create a new class"),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      (appUser.position == "student")
                          ? addClassCode(context)
                          : createClass(context);
                    },
                  )
                ],
              ),
            ),
            Container(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for (int i = 0; i < appUser.classes.length; i++) buildCard(i)
                ],
              ),
            ),
          ],
        ));
  }
}
