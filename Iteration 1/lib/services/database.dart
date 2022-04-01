import 'dart:async';
import 'package:nea_prototype_1/models/class_details.dart';
import 'package:nea_prototype_1/models/questionInfo.dart';
import 'package:nea_prototype_1/models/quiz.dart';
import '../main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

class DatabaseService {
// ADDING DATA
  // adding quiz data --> opens the document with the quizId provided and adds the Map quizData as the data inside
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

  // adding question data --> open the collection within the document with the quizId provided
  // adds the Map questionData as the data inside the collection
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

  // adding user data --> fetches the uid of the current user, adds the map userData to the document with the quizId
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

// FETCHING CLASSES
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
    appUser.classes =  await convertToClassDetailsStructure(classesFetched.toList());
    print(appUser.classes);
  }

  // retrieves teacher's classes from Firebase
  Future<void> getTeacherClasses() async {
    final groups = await Firestore.instance
        .collection('Classes')
        .where('teacherId', isEqualTo: appUser.uid)
        .getDocuments()
        .catchError((e) {
      print(e);
    });
    final groupsFetched = groups.documents.map((doc) => doc.data);
    appUser.classes = await convertToClassDetailsStructure(groupsFetched.toList());
    print(appUser.classes);
  }
  // adds new class created by a teacher to Firebase
  Future<void> addNewClassToFirebase(Map<String, dynamic> classData) async {
    await Firestore.instance
        .collection("Classes")
        .document(classData['classId'])
        .setData(classData)
        .catchError((e) {
      print("error" + e);
    });
    List<ClassDetails> classDetails =
        await convertToClassDetailsStructure([classData]);
    appUser.classes.add(classDetails[0]);
    getTeacherClasses();
  }


//FETCHING QUIZZES
  //adding a quiz made by a teacher to a class
  Future<void> addQuizToClass(String classId,String quizId) async {
     await Firestore.instance
        .collection("Classes")
        .document(classId)
        .collection('quizIds')
        .add({'quizId': quizId})
        .catchError((e) {
      print("error" + e);
    });
  }

  // returns all the info about the quizzes that the current user has created
  Future<void> getUserQuizzes() async {
    // queries the database to return all documents in which the userId field matches the appUser's uid
    final query = await Firestore.instance
        .collection("Quiz")
        .where("userId", isEqualTo: appUser.uid)
        .getDocuments();
    // converts the data within the queries into a map
    final quizzesFetched = query.documents.map((doc) => doc.data);
    // turns the map to a list, converts it to Quiz Structure and saves to appUser.quizzes
    appUser.quizzes = convertToQuizStructure(quizzesFetched.toList());

    // iterates through each quiz in appUser.quizzes
    for (int i = 0; i < appUser.quizzes.length; i++) {
      // fetches the documents in the collection of the document using the quizId provided
      final questionsQuery = await Firestore.instance
          .collection("Quiz")
          .document(appUser.quizzes[i].quizId)
          .collection("q")
          .getDocuments();
      // converts the documents in the query into a list of Document Snapshots
      List<DocumentSnapshot> questionDetails = questionsQuery.documents;
      // for each question stored as a Document Snapshot, obtain the data, 
      for (DocumentSnapshot question in questionDetails) {
        Map<String, dynamic> optionsData =
            question.data; // as  Map<String,dynamic>;
        // instance of Question Info which holds all the information about a question
        QuestionInfo questionInfo = QuestionInfo(
          // obtain the question data using key value pairs
            optionsData["question"], optionsData["correctAnswer"], [
          optionsData["incorrectOption1"],
          optionsData["incorrectOption2"],
          optionsData["incorrectOption3"]
        ]);
        // add the question to the questions array for the quiz
        appUser.quizzes[i].questions.add(questionInfo);
      }
    }
  }

// retrieves preset quizzes for the user
  Future<void> getPresetQuizzes()async{
    // queries the database to return all documents in which the difficulty field matches the appUser's yrGroup
    final query = await Firestore.instance
        .collection("PresetQuizzes")
        .where("difficulty", isEqualTo: appUser.yearGroup )
        .getDocuments();
    // converts the data within the queries into a map
    final quizzesFetched = query.documents.map((doc) => doc.data);
    // turns the map to a list, converts it to Quiz Structure and saves to appUser.presetQuizzes
    appUser.presetQuizzes = convertToQuizStructure(quizzesFetched.toList());
    for (int i = 0; i < appUser.presetQuizzes.length; i++) {
      // fetches the documents in the collection of the document using the quizId provided
      final questionQuery = await Firestore.instance
          .collection("PresetQuizzes")
          .document(appUser.presetQuizzes[i].quizId)
          .collection("q")
          .getDocuments();
      // converts the documents in the query into a list of Document Snapshots
      List<DocumentSnapshot> questionDetails = questionQuery.documents;
      // for each question stored as a Document Snapshot, obtain the data, 
      for (DocumentSnapshot question in questionDetails) {
        Map<String, dynamic> optionsData =
            question.data; // as  Map<String,dynamic>;
        // instance of Question Info which holds all the information about a question
        QuestionInfo questionInfo = QuestionInfo(
          // obtain the question data using key value pairs
            optionsData["question"], optionsData["correctAnswer"], [
          optionsData["incorrectOption1"],
          optionsData["incorrectOption2"],
          optionsData["incorrectOption3"]
        ]);
        // add the question to the questions array for the quiz
        appUser.presetQuizzes[i].questions.add(questionInfo);
      }
    }
  }
// retrieves class quizzes for the user
   Future<void> getClassQuizzes(chosenClass) async {
     //gets all the quizIds of the class quizzes
     final query = await Firestore.instance
     .collection('Classes')
     .document(chosenClass.classId)
     .collection('quizIds')
     .getDocuments();
     // converts the data within the queries into a map
     final quizzesFetched = query.documents.map((doc) => doc.data);

     // iterates through each quiz in appUser.quizzes
     for (int i = 0; i < quizzesFetched.length;i++){
      chosenClass.quizzes = convertToQuizStructure(quizzesFetched.toList());
      
    for (int i = 0; i < chosenClass.quizzes.length; i++) {
      final titleQuery = await Firestore.instance
        .collection('Quiz')
        .document(chosenClass.quizzes[i].quizId)
        .get();
      final titlesFetched = titleQuery.data;
      final quizTitle = titlesFetched['quizTitle'];
      // fetches the documents in the collection of the document using the quizId provided
      final questionQuery = await Firestore.instance
          .collection("Quiz")
          .document(chosenClass.quizzes[i].quizId)
          .collection("q")
          .getDocuments();
      // converts the documents in the query into a list of Document Snapshots
      List<DocumentSnapshot> questionDetails = questionQuery.documents;
      // for each question stored as a Document Snapshot, obtain the data, 
      for (DocumentSnapshot question in questionDetails) {
        Map<String, dynamic> optionsData =
            question.data; // as  Map<String,dynamic>;
        QuestionInfo questionInfo = QuestionInfo(
          // obtain the question data using key value pairs
            optionsData["question"], optionsData["correctAnswer"], [
          optionsData["incorrectOption1"],
          optionsData["incorrectOption2"],
          optionsData["incorrectOption3"]
        ]);
        // set the quiz title fetched as the quizTitle for the quiz
      chosenClass.quizzes[i].quizTitle = quizTitle;
      // add the question to the questions array for the quiz
      chosenClass.quizzes[i].questions.add(questionInfo);
   }}}
   }
    
//FETCHING OTHER DATA
  // fetches student's name using the parameter studentId
  Future<String> fetchStudentName(String studentId) async {
    final query = await Firestore.instance.collection('Users')
    .document(studentId).get();
    Map<String, dynamic> data = query.data;
    String name = data['name'];
    return name;
  }
}
