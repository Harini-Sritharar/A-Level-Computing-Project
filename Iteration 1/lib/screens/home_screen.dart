import 'package:flutter/material.dart';
import 'package:nea_prototype_1/button.dart';
import 'package:nea_prototype_1/screens/Authentication/welcome_screen.dart';
import 'package:nea_prototype_1/screens/Quiz/create_quiz.dart';
import 'package:nea_prototype_1/screens/preset_quizzes_menu.dart';
import 'package:nea_prototype_1/screens/profile_screen.dart';
import '../main.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key, required this.name}) : super(key: key);
  final String name;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}



class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
        print("Index changed");
      });
    }
    const List<Widget> _pages = <Widget>[
    Icon(Icons.call, size: 150),
    Icon(Icons.call, size: 150),
    Icon(Icons.call, size: 150),
  ];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.name + " Home Page"),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue[100],
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.red),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_rounded),
              label: 'Profile',
              backgroundColor: Colors.green),
          BottomNavigationBarItem(
              icon: Icon(Icons.leaderboard),
              label: 'Leaderboard',
              backgroundColor: Colors.purple),
          BottomNavigationBarItem(
              icon: Icon(Icons.logout_rounded),
              label: 'Log Out',
              backgroundColor: Colors.yellow),
        ],
        onTap: _onItemTapped,
        selectedItemColor: Colors.white,
        currentIndex: _selectedIndex,
      ),
       floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => CreateQuiz()));
          },
          child: const Icon(Icons.add)),
      body: Center(
            child: Container(
                child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[
            //SizedBox(height: 50.0),
            GenericButton("Profile", () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfileScreen(
                            name: widget.name,
                          )));
            }),
            SizedBox(height: 35.0),
            GenericButton("Leaderboard", () {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Awesome feature is in the works! 😎'),
              ));
            }),
            SizedBox(height: 35.0),
            GenericButton("Pre Set", () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => PresetMenu()));
            }),
            SizedBox(height: 35.0),
            GenericButton("By You", () {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('I don\'t know who you are though 🤔'),
              ));
            }),
            SizedBox(height: 75.0),
            GenericButton("Sign Out", () {
              authService.signOut();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WelcomeScreen(),
                  ));
            }),])
      
      
      
      
      )));}
     
          // ],
          // ))

    }