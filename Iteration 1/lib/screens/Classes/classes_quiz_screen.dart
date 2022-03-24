import 'package:flutter/material.dart';
import 'package:nea_prototype_1/main.dart';
import 'package:nea_prototype_1/screens/Classes/classes_information_screen.dart';
import 'package:nea_prototype_1/screens/Quiz/Navigation/quiz_navigator.dart';

class ClassQuizScreen extends StatefulWidget {
  final int value;

  const ClassQuizScreen(this.value);
  @override
  State<ClassQuizScreen> createState() => _ClassQuizScreenState();
}

class _ClassQuizScreenState extends State<ClassQuizScreen> {
  @override
  Widget build(BuildContext context) {
    var currentClass = appUser.classes[widget.value];

    if (currentClass.quizzes.length > 0) {
    //return Scaffold(
      //appBar: AppBar(backgroundColor: Colors.teal,),
  return Container(
      decoration: BoxDecoration(color: Colors.blue),
      height: 200,
      child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          children: [
            for (int i = 0; i < currentClass.quizzes.length; i++)
              customWidgets.createCard(i, context,
                  appUser.classes[widget.value].quizzes) 
                  // Container(
            //     child: Text(currentClass.quizzes[i].quizId)),

            //       customWidgets.buildCard(context, i, currentClass.quizzes, (){Navigator.push(context,
            // MaterialPageRoute(builder: (context) => QuizNavigator(currentClass.quizzes[i].questions)));}
            // customWidgets.createCard(i,context,appUser.classes[widget.value].quizzes)
            // for (int i = 0; i < appUser.classes.length; i++)
            // Card(child: Te,)
            // customWidgets.createCard(i, context, appUser.classes[i].quizzes)
            //         buildCard(
            //             context,
            //             i,
            //             appUser.classes,
            //             (){Navigator.push(context,
            // MaterialPageRoute(builder: (context) => a(i)));}
            // ),
          ]),
    );}
    else{
     return Scaffold(
       backgroundColor: Colors.blue,
       body: Container(
         
         child: Center(
           child: Text('No quizzes added yet! :(',style: TextStyle(color: Colors.white,fontSize: 30),),)
     ));
    }
    //}
    // else{
    //       return Container(child:
    // Column(children: [
    //   Text('No quizzes added yet! :(')
    // ],));
    // }
  }
}
