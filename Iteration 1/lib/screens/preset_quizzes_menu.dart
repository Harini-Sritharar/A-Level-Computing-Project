import 'package:flutter/material.dart';
import 'package:nea_prototype_1/button.dart';
import 'package:nea_prototype_1/screens/quiz_navigator.dart';
import 'package:nea_prototype_1/screens/quiz_screen_function.dart';

import '../questionInfo.dart';

class PresetMenu extends StatelessWidget {
  PresetMenu({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pre Set Quizzes"),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GenericButton(
                "Differentiation",
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizNavigator(
                        [
                          QuestionInfo(
                            "What is dy/dx of cos x?",
                            ["cos x", "sin x", "-sin x", "sec x"],
                          ),
                          QuestionInfo(
                            "Differentiate 5 cosx - 1",
                            ["r x", "sin x", "-sin x", "1 x"],
                          ),
                          QuestionInfo(
                            "bob",
                            ["r x", "2 x", "-sin x", "4 x"],
                          ),
                          QuestionInfo(
                            "stebe",
                            ["cos x", "6 x", "7 x", "sec x"],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
