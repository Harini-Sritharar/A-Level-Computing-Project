import 'package:flutter/material.dart';
import 'package:nea_prototype_1/button.dart';
import 'package:nea_prototype_1/main.dart';
import 'package:nea_prototype_1/models/questionInfo.dart';
import 'package:nea_prototype_1/screens/Quiz/Navigation/quiz_navigator.dart';
import 'package:nea_prototype_1/screens/home_screen.dart';



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
                "Trigonometry Differentiation",
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizNavigator(
                        [
                          QuestionInfo(
                            "What is dy/dx of cos x?", "-sin x",
                            ["cos x", "sin x", "sec x"], 
                          ),
                          QuestionInfo(
                            "What is dy/dx of sin x?", "cos x",
                            ["cosec x", "tan x", "-cos x"],
                          ),
                          QuestionInfo(
                            "What is dy/dx of tan x?", "sec^2 x", 
                            ["cosec^2 x", "cot x", "-sec x"], 
                          ),
                          QuestionInfo(
                            "What is dy/dx of sec x?","sec x tan x",
                            ["tan x", "cos x sin x", "cos x"],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 35),
              GenericButton(
                "Probability A2",
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizNavigator(
                        [
                          QuestionInfo(
                            "If events A and B are independent: P(A and B)= ?","P(A) * P(B)",
                            ["P(A)", "P(B)", "P(A) + P(B)"]
                          ),
                          QuestionInfo(
                            "If events A and B are independent: P(A|B) = ?",  "P(A)", 
                            ["P(A) / P(B)", "P(B)","P(A) * P(B)"],
                          ),
                          QuestionInfo(
                            "If events A and B are mutually exclusive: P(A and B)= ?", "0",
                            ["P(A) * P(B)", "P(A) + P(B)", "1"], 
                          ),
                          QuestionInfo(
                            "If events A and B are mutually exclusive: P(A or B)= ?","P(A) + P(B)",
                            [ "P(A)", "P(B)", "P(A) - P(B)"], 
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 35),
            ],
          ),
        ),
      ),
    );
  }
}
