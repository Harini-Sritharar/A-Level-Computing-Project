import 'package:flutter/material.dart';
import 'package:nea_prototype_1/main.dart';
import 'package:nea_prototype_1/models/class_details.dart';

class ClassInfoScreen extends StatefulWidget {
  //ClassInfoScreen(int value, { Key? key }) : super(key: key);
  int value;
  ClassInfoScreen(this.value);
  @override
  State<ClassInfoScreen> createState() => _ClassInfoScreenState();
}

class _ClassInfoScreenState extends State<ClassInfoScreen> {
  @override
  Widget build(BuildContext context)  {
    TextStyle myStyle2 = TextStyle(fontSize: 25,fontFamily: 'Montserrat' );
    //i is the index of the class picked in appUser.classes
    ClassDetails chosenClass = appUser.classes[widget.value];
    String _student = "";
    Future<String> getStudentName() async{
      final String student = await databaseService.fetchStudentName("5GdFRDSUPfNpfWzkuGuqZ02w3iw1");
      print(student);
      setState(() {
        _student = student;
      });
      return student;
      //databaseService.fetchStudentName(studentId)
      //  for (int i = 0; i < chosenClass.studentIds.length; i++)
      //   //String id = chosenClass.studentIds[i].toString();
      //   String id;
      //   students.add(id);
      //   print("Student ${student.toString}") ;
      //   return students; 
    }
    // getStudentName(){
    //   databaseService.fetchStudentName(studentId)
    // }
    return Scaffold(
        appBar: AppBar(
          title: Text(chosenClass.className),
          centerTitle: true,
        ),
        body: Center(
          child:Container(
            child: Column(
          children: [
            SizedBox(height: 35,),
            Text("${chosenClass.studentIds}"),
            Text(
              "Subject: ${chosenClass.subject}",
              style: myStyle2,
              maxLines: 1,
            ),
            Text("Class Code : ${chosenClass.classId}",
                style: myStyle2, maxLines: 1),
            Text("Students $_student")
            //Text(chosenClass],
          ],
        ))));
  }
}
