// multidex is enabled so cloud firestore should work :)
import 'dart:async';
// import 'dart:html';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nea_prototype_1/models/questionInfo.dart';
import 'package:nea_prototype_1/models/quiz.dart';
import 'package:random_string/random_string.dart';
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

  // adds the class to the user's classes in Firebase
  Future<void> addExistingClassToUser(String classId) async {
    appUser.classes.add(classId);
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;
    await Firestore.instance
        .collection("Users")
        .document(uid)
        .updateData({'classes': appUser.classes}).catchError((e) {
      print(e);
    });
  }

  
  Future<void> addNewClassToFirebase(Map<String, dynamic> classData) async {
    String classId = randomAlphaNumeric(8);
    await Firestore.instance
        .collection("Classes")
        .document(classId)
        .setData(classData)
        .catchError((e) {
      print("error" + e);
    });
    appUser.classes.add(classId);
  }

  // returns all the info about the quizzes that the current user has created
  Future<void> getQuizzes() async {
    final query = await Firestore.instance
        .collection("Quiz")
        .where("userId", isEqualTo: appUser.uid)
        .getDocuments();

    // final ids = query.documents.map((doc) => doc.documentID);
    final quizzesFetched = query.documents.map((doc) => doc.data);
    appUser.quizzes = convertToQuizStructure(quizzesFetched.toList());
    // print(" ${appUser.quizzes}");
    for (int i = 0; i < appUser.quizzes.length; i++) {
      final questionsQuery = await Firestore.instance
          .collection("Quiz")
          .document(appUser.quizzes[i].quizId)
          .collection("q")
          .getDocuments();

      List<DocumentSnapshot> questionDetails = questionsQuery.documents;
      for (DocumentSnapshot question in questionDetails) {
        Map<String, dynamic> optionsData =
            question.data; // as  Map<String,dynamic>;
        QuestionInfo questionInfo = QuestionInfo(
            optionsData["question"], optionsData["correctAnswer"], [
          optionsData["incorrectOption1"],
          optionsData["incorrectOption2"],
          optionsData["incorrectOption3"]
        ]);
        appUser.quizzes[i].questions.add(questionInfo);
      }
    }
    // List questions = questionsQuery.toList();
    print(appUser.quizzes);
    //print(appUser.quizzes[1].questions);
    // print("Ids $ids");
  }
}
  //  getQuizData(items) async{
  //    final Query userQuizzes = await Firestore.instance.collection("Quiz")
  //     .where('userId',isEqualTo: appUser.uid);
  //   try{
  //     userQuizzes.getDocuments()
  //     .then((querySnapshot) =>
  //     querySnapshot.documents.forEach((element) {
  //     //     items.add(element.data);
  //     //    })
  //     print (items);
  //     return items;
  //   }));
  //   return null;
  //   }
  //   catch(e){
  //     print(e.toString());
  //     return [];
  //   }  
       
  //           // await Firestore.instance.collection("Quiz").getDocuments()
  //     // .then((querySnapshot){


  // }

  

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


