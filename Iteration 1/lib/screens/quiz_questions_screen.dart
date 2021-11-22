import 'package:flutter/material.dart';

import '../button.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  
  var _indexQuestion = 0;

  var _questions = ['What is dy/dx of sin x?', 'What is dy/dx of cos x?'];
  var _answers = [
    ['cos x', '-cos x'],
    ['sin x', '-sin x'],
  ];

  _nextq() {
    setState(() {
      var lastIndex = _questions.length - 1;
      if (_indexQuestion < lastIndex) {
        _indexQuestion++;
      } else {
        // Is the last question
      }
    });
   }

_backq() {
    setState(() {
      //var lastIndex = _questions.length - 1;
      if (_indexQuestion >= 1) {
        _indexQuestion--;
      } else {
        // Is the last question
      }
    });
   }
  @override
  Widget build(BuildContext context) {
     AppBar(
      automaticallyImplyLeading: true,
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(        
        child: Text(_questions[_indexQuestion])),
        for (var answer in _answers[_indexQuestion]) Text(answer),
        //function next
          QuizButton("Back", _backq),
          QuizButton("Next", _nextq)
      ],
    );
  }
}
  // @override
  // Widget build(BuildContext context) {    
  //   return Scaffold(
  //     appBar: AppBar(
  //       actions: []),
  //     );
      
  //     }


    // return Stack(
    //   children: [
    //     SafeArea(
    //       child: Padding(
    //         padding: const EdgeInsets.symmetric(horizontal: 5,) ,)
    //         )
    //         ]
    //     )
    // ;
