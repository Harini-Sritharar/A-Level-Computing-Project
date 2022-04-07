import 'package:flutter/material.dart';
import 'package:nea_prototype_1/screens/BottomNavBar/bottom_nav_bar.dart';
import 'package:walkthrough/flutterwalkthrough.dart';
import 'package:walkthrough/walkthrough.dart';

class WalkthroughScreen extends StatelessWidget {
  // list of walkthrough screens
  final List<Walkthrough> list = [
    Walkthrough(
      title: "VIEW YOUR PROFILE", // title of the screen
      content: // content of the screen
          "View all your details here and check regularly for updated statistics!",
      imageIcon: Icons.person, // icon to be shown on the screen
    ),
    Walkthrough(
        title: "JOIN CLASSES",
        content: "Connect with teachers and students to boost learning!",
        imageIcon: Icons.class__outlined),
    Walkthrough(
      title: "CREATE QUIZZES",
      content: "Create your own quizzes to revise and share!",
      imageIcon: Icons.add,
    ),
    Walkthrough(
      title: "EXPLORE PRESET QUIZZES",
      content: "Navigate the selection of preset quizzes catered towards your needs!",
      imageIcon: Icons.quiz,
    ),
    Walkthrough(
      title: "BY YOU QUIZZES",
      content: "Made by you, for you!",
      imageIcon: Icons.question_answer_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // returns an Intro Screen for each screen 
    return IntroScreen(
      list,
      // on the final screen, the next button takes the user to the Bottom Nav Bar
      MaterialPageRoute(builder: (context) => BottomNavBar()),
    );
  }
}
