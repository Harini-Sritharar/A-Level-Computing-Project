import 'package:flutter/material.dart';
import 'package:nea_prototype_1/screens/Authentication/welcome_screen.dart';
import 'package:nea_prototype_1/screens/Quiz/Menus/by_you_quizzes_menu.dart';
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
      HomeScreen(name: appUser.name),
      ProfileScreen(),
      PresetMenu(),
      ByYouMenu(),
    ];
  }

  List<PersistentBottomNavBarItem> buildItems() {
    return [
      PersistentBottomNavBarItem(icon: Icon(Icons.home_filled), title: "Home"),
      PersistentBottomNavBarItem(
          icon: Icon(Icons.account_circle_rounded), title: "Profile"),
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
      navBarStyle: NavBarStyle.style13,
    );
  }
}
