// multidex is enabled so cloud firestore should work :)
import 'dart:async';
import 'package:nea_prototype_1/models/class_details.dart';
import 'package:nea_prototype_1/models/questionInfo.dart';
import 'package:nea_prototype_1/models/quiz.dart';
import '../main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

class DatabaseService {
  // adding quiz data
  Future<void> addQuizData(Map<String, String> quizData, String quizID) async {
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

  // adds the student to the class in Firebase
  Future<void> addStudentToClass(String classId) async {
    assert(appUser.position == "student");
    await Firestore.instance
        .collection("Classes")
        .document(classId)
        .updateData({
      'studentIds': FieldValue.arrayUnion([appUser.uid])
    }).catchError((e) {
      print(e);
    });
    await getStudentClasses();
  }

  // retrieves student's classes from Firebase
  Future<void> getStudentClasses() async {
    final classes = await Firestore.instance
        .collection("Classes")
        .where('studentIds', arrayContains: appUser.uid)
        .getDocuments()
        .catchError((e) {
      print("error" + e);
    });
    print(classes);
    final classesFetched = classes.documents.map((doc) => doc.data);
    appUser.classes = convertToClassDetailsStructure(classesFetched.toList());
    print(appUser.classes);
  }

  Future<void> getTeacherClasses() async {
    final groups = await Firestore.instance
        .collection('Classes')
        .where('teacherId', isEqualTo: appUser.uid)
        .getDocuments()
        .catchError((e) {
      print(e);
    });
    final groupsFetched = groups.documents.map((doc) => doc.data);
    appUser.classes = convertToClassDetailsStructure(groupsFetched.toList());
    print(appUser.classes);
  }

  Future<void> addNewClassToFirebase(Map<String, dynamic> classData) async {
    await Firestore.instance
        .collection("Classes")
        .document(classData['classId'])
        .setData(classData)
        .catchError((e) {
      print("error" + e);
    });
    List<ClassDetails> classDetails =
        convertToClassDetailsStructure([classData]);
    appUser.classes.add(classDetails[0]);
    getTeacherClasses();
  }

  // returns all the info about the quizzes that the current user has created
  Future<void> getQuizzes() async {
    final query = await Firestore.instance
        .collection("Quiz")
        .where("userId", isEqualTo: appUser.uid)
        .getDocuments();

    final quizzesFetched = query.documents.map((doc) => doc.data);
    appUser.quizzes = convertToQuizStructure(quizzesFetched.toList());
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
    print(appUser.quizzes);
  }
  Future<String> fetchStudentName(String studentId) async {
    final query = await Firestore.instance.collection('Users')
    .document(studentId).get();
    print("Query $query");
    Map<String, dynamic> data = query.data;
    print("Data $data");
    String name = data['name'];
    print("Name $name");
    return name;
  }
}
