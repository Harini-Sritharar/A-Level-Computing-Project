import 'package:flutter/material.dart';
import 'package:nea_prototype_1/main.dart';
import 'package:nea_prototype_1/screens/Classes/classes_information_screen.dart';

class ClassQuizScreen extends StatefulWidget {
final int value;

  const ClassQuizScreen(this.value);
  @override
  State<ClassQuizScreen> createState() => _ClassQuizScreenState();
}

class _ClassQuizScreenState extends State<ClassQuizScreen> {
  @override
  Widget build(BuildContext context) {
    if (appUser.classes[widget.value].quizzes.length < 1) {
     return Container(
      decoration: BoxDecoration(color: Colors.blue),
                      height: 200,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          for (int i = 0; i < appUser.classes[widget.value].quizzes.length; i++) 
                          customWidgets.createCard(i,context,appUser.classes[widget.value].quizzes) 
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
          return Container(child: 
    Column(children: [
      Text('No quizzes added yet! :(')
    ],));
    }

  }
}