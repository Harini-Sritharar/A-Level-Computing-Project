import 'package:flutter/material.dart';
import 'package:nea_prototype_1/button.dart';
import 'package:nea_prototype_1/screens/quiz_navigator.dart';
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
                "Trigonometry Differentiation",
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizNavigator(
                        [
                          QuestionInfo(
                            "What is dy/dx of cos x?",
                            [("cos x"), "sin x", "-sin x", "sec x"], [false,false,true,false],
                          ),
                          QuestionInfo(
                            "What is dy/dx of sin x?",
                            ["cosec x", "tan x", "-cos x", "cos x"],[false,false,true,false],
                          ),
                          QuestionInfo(
                            "What is dy/dx of tan x?",
                            ["sec^2 x", "cosec^2 x", "cot x", "-sec x"],[false,false,true,false],
                          ),
                          QuestionInfo(
                            "What is dy/dx of sec x?",
                            ["tan x", "cos x sin x", "sec x tan x", "cos x"],[false,false,true,false],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              // GenericButton(
              //   "Probability A2",
              //   () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => QuizNavigator(
              //           [
              //             QuestionInfo(
              //               "If events A and B are independent: P(A and B)= ?",
              //               ["P(A)", "P(B)", "P(A) * P(B)", "P(A) + P(B)"],
              //             ),
              //             QuestionInfo(
              //               "If events A and B are independent: P(A|B) = ?",
              //               ["P(A) / P(B)", "P(B)", "P(A)", "P(A) * P(B)"],
              //             ),
              //             QuestionInfo(
              //               "If events A and B are mutually exclusive: P(A and B)= ?",
              //               ["P(A) * P(B)", "0", "P(A) + P(B)", "1"],
              //             ),
              //             QuestionInfo(
              //               "If events A and B are mutually exclusive: P(A or B)= ?",
              //               ["P(A) + P(B)", "P(A)", "P(B)", "P(A) - P(B)"],
              //             ),
              //           ],
              //         ),
              //       ),
              //     );
              //   },
              // )
            ],
          ),
        ),
      ),
    );
  }
}
