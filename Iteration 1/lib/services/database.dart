// multidex is enabled so cloud firestore should work :)
import 'package:cloud_firestore/cloud_firestore.dart';

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
    await Firestore.instance.collection("Quiz").document(quizID).collection("qna")
    .add(questionData).catchError((e){
      print(e);
    });
}
}