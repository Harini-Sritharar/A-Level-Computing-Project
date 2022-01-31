import 'package:flutter/material.dart';
import 'package:nea_prototype_1/screens/home_screen.dart';
import 'package:nea_prototype_1/services/database.dart';

import '../../button.dart';
import '../../main.dart';


class AddQuizQuestion extends StatefulWidget {
  final String quizID;
  AddQuizQuestion(this.quizID);
  @override
  _AddQuizQuestionState createState() => _AddQuizQuestionState();
}

class _AddQuizQuestionState extends State<AddQuizQuestion> {
  final _formKey = GlobalKey<FormState>();
  late String q, ans1, ans2, ans3, ans4;
  bool _isLoading = false;

  void uploadQuestionData() async {
    if (_formKey.currentState!.validate()) {
      Map<String, String> questionMap = {
        "question": q,
        "option1": ans1,
        "option2": ans2,
        "option3": ans3,
        "option4": ans4,
      };
      await databaseService.addQuData(questionMap, widget.quizID);
      Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => AddQuizQuestion(widget.quizID)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(centerTitle: true, title: Text("Add a question")),
        body: _isLoading
            ? Container(
                child: Center(child: CircularProgressIndicator()),
              )
            : Form(
              key: _formKey,
                child: Center(
                    child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      //question
                      TextFormField(
                        validator: (val) {
                          return val!.isEmpty ? "Enter a question" : null;
                        },
                        decoration: InputDecoration(
                          hintText: "Add Question",
                        ),
                        onChanged: (val) {
                          q = val;
                        },
                      ),
                      //answer1
                      TextFormField(
                        validator: (val) {
                          return val!.isEmpty ? "Enter an answer" : null;
                        },
                        decoration: InputDecoration(
                          hintText: "Option A",
                        ),
                        onChanged: (val) {
                          ans1 = val;
                        },
                      ),
                      //answer2
                      TextFormField(
                        validator: (val) {
                          return val!.isEmpty ? "Enter an answer" : null;
                        },
                        decoration: InputDecoration(
                          hintText: "Option B",
                        ),
                        onChanged: (val) {
                          ans2 = val;
                        },
                      ),
                      //answer3
                      TextFormField(
                        validator: (val) {
                          return val!.isEmpty ? "Enter an answer" : null;
                        },
                        decoration: InputDecoration(
                          hintText: "Option C",
                        ),
                        onChanged: (val) {
                          ans3 = val;
                        },
                      ),
                      //answer4
                      TextFormField(
                        validator: (val) {
                          return val!.isEmpty ? "Enter an answer" : null;
                        },
                        decoration: InputDecoration(
                          hintText: "Option D",
                        ),
                        onChanged: (val) {
                          ans4 = val;
                        },
                      ),
                        SizedBox(height: 20),
                      GenericButton("Add Question", () {
                          uploadQuestionData();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Successful added question 😁'),
            ));
                        }),
                      
                      SizedBox(height: 35),
                      GenericButton("Finish", () {
                         Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => HomeScreen(name: "Your")));
                        }),
                    ],
                  ),
                )),
              ));
  }
}
