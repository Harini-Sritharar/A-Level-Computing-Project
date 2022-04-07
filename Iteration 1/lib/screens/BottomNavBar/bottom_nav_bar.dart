import 'package:flutter/material.dart';
import 'package:nea_prototype_1/screens/Quiz/Create%20Quiz/create_quiz.dart';
import 'package:nea_prototype_1/screens/Quiz/Menus/by_you_quizzes_menu.dart';
import 'package:nea_prototype_1/screens/Quiz/Menus/preset_quizzes_menu.dart';
import 'package:nea_prototype_1/screens/Classes/classes_screen.dart';
import 'package:nea_prototype_1/screens/profile_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}
class _BottomNavBarState extends State<BottomNavBar> {
  final PersistentTabController controller = PersistentTabController(
      initialIndex: 0); //sets the initial index of the controller to 0
  //function which returns a list of all the screens in the navigation bar
  List<Widget> buildScreens() {
    return [
      ProfileScreen(),
      ClassesScreen(),
      CreateQuiz(),
      PresetMenu(),
      ByYouMenu(),
    ];
  }
  // function which returns a list of all the items and icons in the navigation bar
  List<PersistentBottomNavBarItem> buildItems() {
    return [
      PersistentBottomNavBarItem(
          icon: Icon(Icons.account_circle_rounded), title: "Profile"),
      PersistentBottomNavBarItem(
          icon: Icon(Icons.class__outlined), title: "Classes"),
      PersistentBottomNavBarItem(
          icon: Icon(Icons.add, color: Colors.white), title: "Create"),
      PersistentBottomNavBarItem(icon: Icon(Icons.quiz), title: "Preset"),
      PersistentBottomNavBarItem(
          icon: Icon(Icons.question_answer_outlined), title: "By You"),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: controller,
      screens: buildScreens(),
      items: buildItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true, // handles the actions of the back button on Android
      resizeToAvoidBottomInset:
          true, // Moves the screen up when keyboard appears. 
      stateManagement: true, // Preserves the state of each tab screen
      hideNavigationBarWhenKeyboardShows:
          true, // hides the navigation bar when the onscreen keyboard is open
      decoration: NavBarDecoration( // decoration for the naviagation bar
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,// colour for the container which holds the navigation bar
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      navBarStyle: NavBarStyle.style15, // this style allows 5 icons in the navigation bar 
    );
  }
}
