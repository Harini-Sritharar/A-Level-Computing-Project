import 'package:flutter/material.dart';
import 'package:nea_prototype_1/button.dart';
import 'package:nea_prototype_1/screens/Quiz/Create%20Quiz/add_quiz_question.dart';
import 'package:random_string/random_string.dart';
import '../../../main.dart';

class CreateQuiz extends StatefulWidget {
  @override
  _CreateQuizState createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  // form key is used for validation of form fields
  final _formKey = GlobalKey<FormState>();
  late String quizTitle, quizID;
  // boolean value which controls the state of the Circular Progress Indicator
  bool _isLoading = false;
  // function which creates a new quiz
  createNewQuiz() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      // randomly generates an alphanumeric quizId of length 10
      quizID = randomAlphaNumeric(10);
      // creates a map called quizMap which stores all the information about a quiz in key-value pairs
      Map<String, String> quizMap = {
        "quizId": quizID,
        "quizTitle": quizTitle,
        "userId": appUser.uid
      };
      // calls the addQuizData function with the parameters of the quizMap and randomly generated quizId
      await databaseService.addQuizData(quizMap, quizID).then((value) {
        setState(() async {
          _isLoading = false;
          // runs the initialise function 
          await appUser.initialise();
          // user navigated to the next screen where they can add questions
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => AddQuizQuestion(quizID)));
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // these 4 lines of code specify the properties of the Container
      decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover,// makes sure that the image covers the entire Container
            image: AssetImage('lib/assets/create_quiz_screen_bg.jpg')), // background image of the screen
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent, // the background colour must be transparent in order for the background image to be visible
          appBar: AppBar(
            centerTitle: true, // title is centered in the middle of the AppBar
            flexibleSpace: Container(
              height: 150,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.white, Colors.teal, Colors.blue])),
            ),
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(60),
                child: Container(
                  padding: EdgeInsets.all(30),
                  alignment: Alignment.center,
                  child: Text("Create a new quiz here!",style: constants.nameStyle))),
          ),
          body: _isLoading
              ? Container(
                  child: Center(child: CircularProgressIndicator()),
                  // whilst _isLoading is true, the body of the screen will show only the Circular Progress Indicator
                )
              : Form(
                  key: _formKey,
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          SizedBox(height: 35),
                          // the TextFormField is a TextField that has the validation property due to being inside a Form
                          TextFormField(
                            validator: (val) {
                              return val!.isEmpty ? " Enter Quiz Title" : null;
                            },
                            decoration: InputDecoration(
                              hintText: "Quiz Title",
                            ),
                            onChanged: (val) {
                              quizTitle = val; // value entered by user will be stored in the variable quizTitle
                            },
                          ),
                          SizedBox(height: 20),
                          Spacer(),
                          GenericButton("Create", () {
                            createNewQuiz(); 
                            appUser.initialise();
                          }),
                          SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ))),
    );
  }
}
