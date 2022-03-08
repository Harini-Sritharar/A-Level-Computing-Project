import 'package:flutter/material.dart';
import 'package:nea_prototype_1/button.dart';

class ClassesScreen extends StatefulWidget {
  const ClassesScreen({Key? key}) : super(key: key);

  @override
  State<ClassesScreen> createState() => _ClassesScreenState();
}

class _ClassesScreenState extends State<ClassesScreen> {
  TextEditingController myController = TextEditingController();
  Widget buildCard(){
     return Container(
                      color: Colors.red,
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      width: 200,
                      height: 100,
                    );
  }
 void addClassCode(BuildContext context) async {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('TextField in Dialog'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                },
                controller: myController,
                decoration: InputDecoration(hintText: "Enter Class Code"),
              ),
            ],
          ),
          actions: [
            GenericButton("Add", (){})
          ],
        );
      });
}
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: AppBar(
          title: Text("Classes"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                children: [
                  Text("Hi Classes"),
                  IconButton(icon:Icon(Icons.add),onPressed: (){
                   addClassCode(context);
                  },)
                ],
              ),
            ),
            Container(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for (int i = 0; i < 5; i++)
                   buildCard()
                ],
              ),
            )
          ],
        ));
  }
}
