// multidex is enabled so cloud firestore should work :)
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth auth = FirebaseAuth.instance;


class DatabaseService {

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

 Future getName() async{
    //gets current user
    final FirebaseUser user = await auth.currentUser();
    // gets their user id
    final uid = user.uid;
    // opens the Users collection
    CollectionReference users = Firestore.instance.collection("Users");
    return FutureBuilder<DocumentSnapshot>(
      future: users.document(uid).get(),
  
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError){
          print("SOMETHINGS WRONG CAPTAIN");
        }
        if (snapshot.hasData && !snapshot.data!.exists){
          print("DOC WHO ARE YOU");
        }
        // if (snapshot.connectionState == ConnectionState.done){
        Map <String,dynamic> data = snapshot.data! as Map<String,dynamic>;
        var username = (data['name']);
        print("I FOUND YOU" + username);
        print(username);
        return(username);
        // }
        // print("LOADING WAITTTTTTTTT");
        // return(Text("User"));

      },);
    

    // var query = await collection.get();
    // re
    // getData(name)
    //Future <DocumentSnapshot> snapshot = UserCollection.docu 
  }


}
