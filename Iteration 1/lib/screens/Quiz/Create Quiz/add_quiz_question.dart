import 'package:flutter/material.dart';
import 'package:nea_prototype_1/main.dart';
import 'package:nea_prototype_1/screens/Quiz/Create%20Quiz/create_quiz.dart';
import '../../../button.dart';

class AddQuizQuestion extends StatefulWidget {
  final String quizID;
  AddQuizQuestion(this.quizID);
  @override
  _AddQuizQuestionState createState() => _AddQuizQuestionState();
}

class _AddQuizQuestionState extends State<AddQuizQuestion> {
  // form key is used for validation of form fields
  final _formKey = GlobalKey<FormState>();
  late String q, ans1, ans2, ans3, ans4;
  // boolean value which controls the state of the Circular Progress Indicator
  bool _isLoading = false;
  // function which uploads the question data 
  void uploadQuestionData() async {
    if (_formKey.currentState!.validate()) {
      // creates a map called questionMap which stores all the information about a question in key-value pairs
      Map<String, String> questionMap = {
        "question": q,
        "correctAnswer": ans1,
        "incorrectOption1": ans2,
        "incorrectOption2": ans3,
        "incorrectOption3": ans4,
      };
      // calls the addQuData function with the parameters of the questionMap and quizId
      await databaseService.addQuData(questionMap, widget.quizID);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Successful added question 😁'),
            ));
          // user navigated to the next screen where they can add questions
      Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => AddQuizQuestion(widget.quizID)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        // the widgets will not resize themeselves to avoid being obstructed by the keyboard 
        resizeToAvoidBottomInset: false, 
          appBar: AppBar(centerTitle: true, title: Text("Add a question")),
          // whilst _isLoading is true, the body of the screen will show only the Circular Progress Indicator
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
                            return val!.isEmpty ? " ⚠️ Enter a question" : null;
                          },
                          decoration: InputDecoration(
                            hintText: "Enter Question",
                          ),
                          onChanged: (val) {
                            q = val; // value entered by user will be stored in the variable q
                          },
                        ),
                        //field in which correct answer is input
                        TextFormField(
                          validator: (val) {
                            return val!.isEmpty ? "⚠️ Enter an answer" : null;
                          },
                          decoration: InputDecoration(
                            hintText: "Correct Answer",
                          ),
                          onChanged: (val) {
                            ans1 = val;
                          },
                        ),
                        //field in which first incorrect answer is input
                        TextFormField(
                          validator: (val) {
                            return val!.isEmpty ? "⚠️ Enter an answer" : null;
                          },
                          decoration: InputDecoration(
                            hintText: "Incorrect Option 1",
                          ),
                          onChanged: (val) {
                            ans2 = val;
                          },
                        ),
                        //field in which second incorrect answer is input
                        TextFormField(
                          validator: (val) {
                            return val!.isEmpty ? "⚠️ Enter an answer" : null;
                          },
                          decoration: InputDecoration(
                            hintText: "Incorrect Option 2",
                          ),
                          onChanged: (val) {
                            ans3 = val;
                          },
                        ),
                        //field in which third incorrect answer is input
                        TextFormField(
                          validator: (val) {
                            return val!.isEmpty ? "⚠️ Enter an answer" : null;
                          },
                          decoration: InputDecoration(
                            hintText: "Incorrect Option 3",
                          ),
                          onChanged: (val) {
                            ans4 = val;
                          },
                        ),
                          SizedBox(height: 20),
                        // this button saves the question data inputted and returns the user back to the Add Question Screen
                        GenericButton("Add Question", () {
                            uploadQuestionData(); 
                          }),
                        SizedBox(height: 35),
                        // this button takes the user back to the Create Quiz screen
                        GenericButton("Finish", () {
                           Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => CreateQuiz())); 
                          }),
                      ],
                    ),
                  )),
                )),
    );
  }
}
