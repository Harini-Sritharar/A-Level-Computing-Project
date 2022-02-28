import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nea_prototype_1/button.dart';
import 'package:nea_prototype_1/main.dart';
import 'package:nea_prototype_1/screens/Quiz/Navigation/questionInfo.dart';
import 'package:nea_prototype_1/services/database.dart';

class ByYouMenu extends StatefulWidget {
  ByYouMenu({
    Key? key,
  }) : super(key: key);
  @override
  _ByYouMenuState createState() => _ByYouMenuState();
}
// fetchDBList(List quizzes) async{
//   dynamic result = await databaseService.getQuizData(quizzes);
//   print(result);
//   if (result != null){
//     quizzes = result;
//     return quizzes;
//   }
//   return null;
// //  
// }
class _ByYouMenuState extends State<ByYouMenu> {
  final Map<String,String> quizzes = appUser.quizzes as Map<String,String>;
  Stream quizStream = appUser.quizzes as Stream;


  //   for (var i = 0; i < appUser.quizzes.length; i++)
  //     return Card(
  //       child: Column(children: <Widget>[
  //         ListTile(
  //           title: appUser.quizzes[i]['quizTitle'],
  //           subtitle: ,)
  //       ],)
  //     );
  // }
  Widget quizList(){
    return Container(
      child: StreamBuilder(
        stream: quizStream,
        builder: (context,snapshot){
          return snapshot.data != null 
          ? Container():
          ListView.builder(
            itemCount: appUser.quizzes.length,
            itemBuilder: (context, index){
              return QuizTile(snapshot.data!.
              // requireData[index].data()['quizTitle']);
            });
        },
      )

    );
  }

      


  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
  
  
   //   appBar: AppBar(
    //     centerTitle: true,
    //     title: Text("Quizzes made by You"),
 
          
    

    // return StreamBuilder<QuerySnapshot>(
    //   stream: _usersStream,
    //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    //     if (snapshot.hasError) {
    //       return Text('Something went wrong');
    //     }

    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return Text("Loading");
    //     }

    //     return ListView(
    //       children: snapshot.data!.documents.map((DocumentSnapshot document) {
    //       Map<String, dynamic> data = document.data! as Map<String, dynamic>;
    //         return ListTile(
    //           title: Text(data['quizId']),
    //           subtitle: Text(data['company']),
    //         );
    //       }).toList(),
    //     );
    //   },
    // );
}
// ignore: must_be_immutable
class QuizTile extends StatelessWidget {
  String qTitle;
  QuizTile(this.qTitle);


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
            child: Column(
              children: [
                Text(qTitle)
              ]
            )
          )
        ],
      )
    );
  }
  }
