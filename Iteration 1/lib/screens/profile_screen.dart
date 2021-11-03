import 'package:flutter/material.dart';
//import 'package:nea_prototype_1/screens/signUp_screen.dart';
class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key, required this.name}) : super(key: key);
  //final String greeting;
  final String name;
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}
class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
   //name = myController.text;
   return Scaffold(
     backgroundColor: Colors.white,
     appBar: AppBar(
       //title: Text("Hi " + widget.name + " !"),
       title: Text(widget.name + "'s Profile"),
       //title: Text("Hi Harini!"),
       centerTitle: true,
       automaticallyImplyLeading: false,
     ),
     body: Center(
       child: Column(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.transparent,
            minRadius: 50.0,
            child: CircleAvatar()
              //Text("H") ,
              //backgroundImage: NetworkImage(),
                //NetworkImage('https://avatars0.githubusercontent.com/u/28812093?s=460&u=06471c90e03cfd8ce2855d217d157c93060da490&v=4')
            ),
            ],
       ),),
   );
  }

}