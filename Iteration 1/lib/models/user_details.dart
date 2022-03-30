import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nea_prototype_1/models/class_details.dart';
import 'package:nea_prototype_1/models/quiz.dart';
import '../main.dart';

class UserDetails {
  String uid, name = "", email = "", position = "", yearGroup = "";
  List<ClassDetails> classes = [];
  List<Quiz> quizzes = [];
  List<Quiz> presetQuizzes = [];
  UserDetails(this.uid);

  Future<void> fillBasicData() async {
    DocumentSnapshot document =
        await Firestore.instance.collection("Users").document(uid).get();
    Map<String, dynamic> data = document.data as Map<String, dynamic>;
    print(data);
    name = data['name'];
    email = data['email'];
    position = data['position'];
    yearGroup = data['yearGroup'];
  }


  Future<void> initialise() async {
    await fillBasicData();
    await databaseService.getUserQuizzes();
    if (position == 'student') {
      await databaseService.getStudentClasses();
      await databaseService.getPresetQuizzes();
    } else {
      await databaseService.getTeacherClasses();
    }
     //for (int i = 0; i < appUser.classes.length; i++) {
    // await databaseService.getClassQuizzes(appUser.classes[0]);
    //  //}
  }
}
