// multidex is enabled so cloud firestore should work :)
import 'dart:async';
import '../main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

class DatabaseService{
  Future <void> addQuizData(Map <String, dynamic> quizData, String quizID) async{
    //getting the instance of Firebase,going inside the collection
    await Firestore.instance.
    collection("Quiz").
    document(quizID).setData(quizData) 
    .catchError((e){
      print(e.toString());
    },
    );
    }

  Future <void> addQuData(Map <String, dynamic> questionData, String quizID) async{
    await Firestore.instance.collection("Quiz").document(quizID).collection("q")
    .add(questionData).catchError((e){
      print(e);
    });
  }

  Future <void> addUserData(Map <String,dynamic> userData) async{
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;
    await Firestore.instance.collection("Users").document(uid)
    .setData(userData)
    .catchError((e){
      print(e);
    });

  }

}