import 'package:flutter/material.dart';
import 'package:nea_prototype_1/button.dart';
import 'package:nea_prototype_1/main.dart';
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
    return Container(
      color: Colors.red,
      margin: EdgeInsets.symmetric(horizontal: 5),
      width: 200,
      height: 200,
      child: Center(child: Column(
        children: [
          Spacer(),
          Text(appUser.classes[i].className),
          Text(appUser.classes[i].subject),
          Spacer(),

        ],
      )),
    );
  }

  void addClassCode(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('TextField in Dialog'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: classCodeController,
                  decoration: InputDecoration(hintText: "Enter Class Code"),
                ),
              ],
            ),
            actions: [
              GenericButton("Add", () {
                databaseService
                .addStudentToClass(classCodeController.text);
                classCodeController.text = "";
                Navigator.pop(context);
              })
            ],
          );
        });
  }

  Map<String, dynamic> createMap() {
    String classId = randomAlphaNumeric(8);
    Map<String, dynamic> classData = {
      'classId' : classId,
      'className': classNameController.text,
      'subject': subjectController.text,
      'teacherId': appUser.uid,
      'studentIds': [],
      'quizzes': []
    };
    return classData;
  }

  void createClass(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Create Class'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
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
            ),
            actions: [
              GenericButton("Add", () {
                Map<String, dynamic> classData =
                    createMap();
                // print("ClassData" );
                databaseService.addNewClassToFirebase(classData);
                classNameController.text = "";
                subjectController.text = "";
                Navigator.pop(context);
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
