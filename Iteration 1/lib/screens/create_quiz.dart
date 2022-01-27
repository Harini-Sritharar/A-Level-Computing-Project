import 'package:flutter/material.dart';
import 'package:nea_prototype_1/button.dart';
class CreateQuiz extends StatefulWidget {
  //const CreateQuiz({ Key? key }) : super(key: key);

  @override
  _CreateQuizState createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  final _formKey = GlobalKey<FormState>();
  late String quizTitle;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create your own quiz!"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Center(
        child:Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              TextFormField(
                validator: (val) {return val!.isEmpty ? "Enter Quiz Title" : null;},
                decoration: InputDecoration(
                  hintText:"Quiz Title",
              ),
              onChanged: (val){
                quizTitle = val;
              },
              ),
              SizedBox(height: 20),
              Spacer(),
              SizedBox(height: 20),
              //GenericButton(msg, linkScreen)
          ],

        ),
        ),
      )));   
  }
  }

