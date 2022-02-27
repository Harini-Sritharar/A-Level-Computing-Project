import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nea_prototype_1/main.dart';
import 'package:nea_prototype_1/services/database.dart';

class ByYouMenu extends StatefulWidget {
  ByYouMenu({
    Key? key,
  }) : super(key: key);

  @override
  _ByYouMenuState createState() => _ByYouMenuState();
}
@override
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
  // late Stream quizStream;
  // Widget quizList(){
  //   return Container(
  //     child: StreamBuilder(
  //       stream: quizStream,
  //       builder: (BuildContext context, snapshot){
  //         if (snapshot.data != null){
  //           return Container();
  //         }

  //         //var data = snapshot.data
  //          });}
  //       },)
  //   );
  // }
  @override
    getQuizzes() async{
      List quizzes = [];
    QuerySnapshot querySnapshot = await Firestore.instance.collection("Quiz").getDocuments();
    final docums = querySnapshot.documents.map((doc) => doc.data).toList();
    quizzes.add(docums);
    return(quizzes);
    // for (int i = 0; i < querySnapshot.documents.length; i++){
    //   var a = querySnapshot.documents[i];
    //   print(a.documentID);
    }
  //List quizzes = getDocs()
  Widget build(BuildContext context) {
    //databaseService.getQuizzes();
     return Scaffold(
       body: Container(
         child: Column(children: [Text("")]),
       ));
  
   //   appBar: AppBar(
    //     centerTitle: true,
    //     title: Text("Quizzes made by You"),
    //   ),
    //   body: Container(
    //     child: ListView.builder(
    //       itemCount: quizzes.length,
    //       itemBuilder: (context,index){
    //         return Card(
    //           child: ListTile(
    //             title: Text(quizzes[index]['quizTitle']),

    //           )
    //         );
    //       }))
    //   );
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
}