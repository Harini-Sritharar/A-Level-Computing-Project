import 'package:flutter/material.dart';
import 'package:nea_prototype_1/button.dart';
import 'package:nea_prototype_1/screens/addQuizQuestion.dart';
import 'package:nea_prototype_1/services/database.dart';
import 'package:random_string/random_string.dart';

class CreateQuiz extends StatefulWidget {
  @override
  _CreateQuizState createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  final _formKey = GlobalKey<FormState>();
  late String quizTitle, quizID;
  bool _isLoading = false;
  DatabaseService databaseService = new DatabaseService();

  void createNewQuiz() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      // randomly generates an alphanumeric quizId of length 10
      quizID = randomAlphaNumeric(10);

// Map <key,value>
      Map<String, String> quizMap = {
        "quizId": quizID,
        "quizTitle": quizTitle,
      };
      await databaseService.addQuizData(quizMap, quizID).then((value) {
        setState(() {
          _isLoading = false;
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => AddQuizQuestion(quizID)));
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Create your own quiz!"),
          centerTitle: true,
        ),
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
                        TextFormField(
                          validator: (val) {
                            return val!.isEmpty ? "Enter Quiz Title" : null;
                          },
                          decoration: InputDecoration(
                            hintText: "Quiz Title",
                          ),
                          onChanged: (val) {
                            quizTitle = val;
                          },
                        ),
                        SizedBox(height: 20),
                        Spacer(),
                        GenericButton("Create", () {
                          createNewQuiz();
                        }),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                )));
  }
}
