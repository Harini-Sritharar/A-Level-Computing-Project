import 'package:flutter/material.dart';
import 'package:nea_prototype_1/screens/Authentication/welcome_screen.dart';
import 'package:nea_prototype_1/screens/Quiz/Create%20Quiz/create_quiz.dart';
import 'package:nea_prototype_1/screens/Quiz/Menus/by_you_quizzes_menu.dart';
import 'package:nea_prototype_1/screens/classes_screen.dart';
import 'package:nea_prototype_1/screens/home_screen.dart';
import 'package:nea_prototype_1/screens/profile_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../main.dart';
import 'Quiz/Menus/preset_quizzes_menu.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final PersistentTabController controller =
      PersistentTabController(initialIndex: 0);
  List<Widget> buildScreens() {
    return [
      ProfileScreen(),
      ClassesScreen(),
      CreateQuiz(),
      PresetMenu(),
      ByYouMenu(),
    ];
  }

  List<PersistentBottomNavBarItem> buildItems() {
    return [
      PersistentBottomNavBarItem(
          icon: Icon(Icons.account_circle_rounded), title: "Profile"),
      PersistentBottomNavBarItem(icon: Icon(Icons.class__outlined),title: "Classes"),
      PersistentBottomNavBarItem(
          icon: Icon(Icons.add,color: Colors.white), title: "Create"),
      PersistentBottomNavBarItem(
          icon: Icon(Icons.question_answer), title: "Preset"),
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
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      // itemAnimationProperties: ItemAnimationProperties(
      //   // Navigation Bar's items animation properties.
      //   duration: Duration(milliseconds: 200),
      //   curve: Curves.ease,
      // ),
      // // screenTransitionAnimation: ScreenTransitionAnimation(
      // //   // Screen transition animation on change of selected tab.
      // //   animateTabTransition: true,
      // //   curve: Curves.ease,
      // //   duration: Duration(milliseconds: 200),
      // // ),

      navBarStyle: NavBarStyle.style15,
    );
  }
}
