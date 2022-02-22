// multidex is enabled so cloud firestore should work :)
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

class DatabaseService {
  // adding quiz data
  Future<void> addQuizData(Map<String, String> quizData, String quizID) async {
    //getting the instance of Firebase,going inside the collection
    await Firestore.instance
        .collection("Quiz")
        .document(quizID)
        .setData(quizData)
        .catchError(
      (e) {
        print(e.toString());
      },
    );
  }

  // adding question data
  Future<void> addQuData(
      Map<String, dynamic> questionData, String quizID) async {
    await Firestore.instance
        .collection("Quiz")
        .document(quizID)
        .collection("q")
        .add(questionData)
        .catchError((e) {
      print(e);
    });
  }

  // adding user data
  Future<void> addUserData(Map<String, dynamic> userData) async {
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;
    await Firestore.instance
        .collection("Users")
        .document(uid)
        .setData(userData)
        .catchError((e) {
      print(e);
    });
  }

  Future<String> getName() async {
    //gets current user
    final FirebaseUser user = await auth.currentUser();
    // gets their user id
    final String uid = user.uid;
    //opens the Users collection
    DocumentSnapshot document =
        await Firestore.instance.collection("Users").document(uid).get();
    Map<String, dynamic> data =
        document.data as Map<String, dynamic>;
    print(data);
    return data['name'];
    // name = data['name']
   
  }

  // Future<String> getQuizzes() async{
    
  // Firestore.instance.collection("Quiz")
  // .where('userId', isEqualTo: appUser.uid).snapshots().listen((data) => { 
  //   print("userId ${data.documents[0]['userId']}"),
  //   appUser.quizzes.add(data.documents[0]['userId'])
  // });
  //   return "";
  

    // docs.then((snpashot) => appUser.quizzes.add());
    //   return "";

  // }
  // return FutureBuilder<DocumentSnapshot>(
  //   future: users.document(uid).get(),

  //   builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
  //     if (snapshot.hasError){
  //       print("SOMETHINGS WRONG CAPTAIN");
  //     }
  //     if (snapshot.hasData && !snapshot.data!.exists){
  //       print("DOC WHO ARE YOU");
  //     }
  //     if (snapshot.connectionState == ConnectionState.done){
  //       Map <String,dynamic> data = snapshot.data! as Map<String,dynamic>;
  //       //name = data['name'];
  //       //return (name);
  //       return Text("Name: ${data['name']}");
  //       //var username = (data['name']);
  //     //print("I FOUND YOU" + username);
  //     //print(username);
  //     //return(username);
  //     }
  //     return Text("Loading");
  //   }
  // );

  // var query = await collection.get();
  // re
  // getData(name)
  //Future <DocumentSnapshot> snapshot = UserCollection.docu

  Future getAllInfo(field) async {
    // gets current user
    final FirebaseUser user = await auth.currentUser();
    // gets their user id
    final uid = user.uid;
    // opens the Users collection
    final Stream<QuerySnapshot> users =
        Firestore.instance.collection("Users").snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: users,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        final data = snapshot.requireData.documents;
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Text('User/s $field is ${data[index]['$field']}');
          },
        );
      },
    );

    // var query = await collection.get();
    // re
    // getData(name)
    //Future <DocumentSnapshot> snapshot = UserCollection.docu
  }
}
