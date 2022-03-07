import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nea_prototype_1/models/quiz.dart';
import 'package:nea_prototype_1/screens/Quiz/score_screen.dart';
import 'package:nea_prototype_1/services/database.dart';

class UserDetails {
  String uid, name = "", email = "", position = "", yearGroup = "";
  List<String> classes = [];
  List<Quiz> quizzes = [];
  UserDetails(this.uid);

  Future<void> fillBasicData() async {
    //opens the Users collection
    DocumentSnapshot document =
        await Firestore.instance.collection("Users").document(uid).get();
    Map<String, dynamic> data =
        document.data as Map<String, dynamic>;
    print(data);
    name = data['name'];
    email = data['email'];
    position = data['position'];
    for (int i = 0; i < (data['classes'].length);i++){
      classes.add(data['classes'][i] as String);
    }
    yearGroup = data['yearGroup'];
  }
   Future addScore(quizId,points) async {
     //adds to the scores list which will be uploaded onto Firebase
     //scores[quizId] = points;
    //print(scores);
    //  Firestore.instance.collection("Quiz").document(quizId).updateData({{"scores": points})
   }







}
