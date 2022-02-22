import 'package:flutter/material.dart';
import 'package:nea_prototype_1/main.dart';

class ByYouMenu extends StatelessWidget {
  ByYouMenu({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //databaseService.getQuizzes();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Quizzes made by You"),
      ),
    
    );

  }
  }