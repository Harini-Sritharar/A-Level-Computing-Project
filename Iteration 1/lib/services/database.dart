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
// ADDING DATA
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
        .updateData({
      'quizzes': FieldValue.arrayUnion([quizId])})
        .catchError((e) {
      print("error" + e);
    });
  }


  // returns all the info about the quizzes that the current user has created
  Future<void> getUserQuizzes() async {
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
  }
  //classId = chosenClass.classId
//   Future<void> getClassQuizzes(chosenClass) async {
//    List quizzes = [];
//    DocumentSnapshot q = await Firestore.instance.collection('Classes')
// .document(chosenClass.classId).get();
//   Map<String,dynamic> data = q.data;
//   print("Class Quizzes $data");
//   //retrieves the quizids of the quizzes added to the class
//     quizzes.add(data['quizzes']);
// print(quizzes)
//   for (int i = 0; i < quizzes.length; i++){
//     String id = quizzes[i].toString();
//     final questionsQuery = await Firestore.instance
//           .collection("Quiz")
//           .document(id)
//           .collection("q")
//           .getDocuments();
//       List<DocumentSnapshot> questionDetails = questionsQuery.documents;
//       for (DocumentSnapshot question in questionDetails) {
//         Map<String, dynamic> optionsData =
//             question.data; // as  Map<String,dynamic>;
//         QuestionInfo questionInfo = QuestionInfo(
//             optionsData["question"], optionsData["correctAnswer"], [
//           optionsData["incorrectOption1"],
//           optionsData["incorrectOption2"],
//           optionsData["incorrectOption3"]
//         ]);
//         chosenClass.quizzes[i].questions.add(questionInfo);


//   }
//   }
//         print(chosenClass.quizzes[1]);
//       }
  
  
// retrieves preset quizzes for the user
  Future<void> getPresetQuizzes()async{
    final query = await Firestore.instance
        .collection("PresetQuizzes")
        .where("difficulty", isEqualTo: appUser.yearGroup )
        .getDocuments();
    final quizzesFetched = query.documents.map((doc) => doc.data);
    appUser.presetQuizzes = convertToQuizStructure(quizzesFetched.toList());
    for (int i = 0; i < appUser.presetQuizzes.length; i++) {
      final questionQuery = await Firestore.instance
          .collection("PresetQuizzes")
          .document(appUser.presetQuizzes[i].quizId)
          .collection("q")
          .getDocuments();
      List<DocumentSnapshot> questionDetails = questionQuery.documents;
      for (DocumentSnapshot question in questionDetails) {
        Map<String, dynamic> optionsData =
            question.data; // as  Map<String,dynamic>;
        QuestionInfo questionInfo = QuestionInfo(
            optionsData["question"], optionsData["correctAnswer"], [
          optionsData["incorrectOption1"],
          optionsData["incorrectOption2"],
          optionsData["incorrectOption3"]
        ]);
        appUser.presetQuizzes[i].questions.add(questionInfo);
      }
    }
  }
  // chosenClasses is of the form appUser.classes[i]
  Future<void> getClassQuizzes(chosenClass)async{
    List<String> quizIds =[];
    final query = await Firestore.instance
        .collection("Classes")
        .where('classId',isEqualTo: chosenClass.classId)
        .getDocuments()
        .catchError((e){
          print(e.toString());
        });

    for (var snapshot in query.documents){
      Map<String,dynamic> data = snapshot.data;
    
      //final split = .split();
      //for (int i = 0; i< data['quizzes'].length)
      chosenClass.quizIds.add(data['quizzes'].toString());
      var split= chosenClass.quizIds[0].split(',');
      print(split);
      // var a = chosenClass.quizIds[0];
      // chosenClass.quizIds = a;
    }
    // chosenClass.quizIds = chosenClass.quizIds[0];
  print('QUIZIds ${chosenClass.quizIds}');
    for (int i = 0; i < chosenClass.quizIds.length; i++){
      // gets the quiz info from Firebase
      final questionQuery = await Firestore.instance
          .collection("Quiz")
          .document(chosenClass.quizIds[i])
          .collection("q")
          .getDocuments();
          //gets all the questions in each quiz
       List<DocumentSnapshot> questionDetails = questionQuery.documents;
       //for each question in the quiz
      for (DocumentSnapshot question in questionDetails) {
        //gets the data
        Map<String, dynamic> optionsData =
            question.data; // as  Map<String,dynamic>;
            //creates a QuestionInfo instance with all the required parame
        QuestionInfo questionInfo = QuestionInfo(
            optionsData["question"], optionsData["correctAnswer"], [
          optionsData["incorrectOption1"],
          optionsData["incorrectOption2"],
          optionsData["incorrectOption3"]
        ]);
        chosenClass.quizzes[i].questions.add(questionInfo);

    }
    }
    
        // .document(chosenClass.classId)
        // .get();
               //.where("classId", isEqualTo: chosenClass.classId
  // print({query.toString()});
    // final quizzesFetched = query.documents.map((doc) => doc.data);
    // chosenClass.quizzes = convertToQuizStructure(quizzesFetched.toList());
    // for (int i = 0; i < chosenClass.quizzes.length; i++) {
    //   final questionQuery = await Firestore.instance
    //       .collection("Quiz")
    //       .document(chosenClass.quizzes[i].quizId)
    //       .collection("q")
    //       .getDocuments();
    //   List<DocumentSnapshot> questionDetails = questionQuery.documents;
    //   for (DocumentSnapshot question in questionDetails) {
    //     Map<String, dynamic> optionsData =
    //         question.data; // as  Map<String,dynamic>;
    //     QuestionInfo questionInfo = QuestionInfo(
    //         optionsData["question"], optionsData["correctAnswer"], [
    //       optionsData["incorrectOption1"],
    //       optionsData["incorrectOption2"],
    //       optionsData["incorrectOption3"]
    //     ]);
    //     chosenClass.quizzes[i].questions.add(questionInfo);
      // }
    // }
  }
//FETCHING OTHER DATA
  Future<String> fetchStudentName(String studentId) async {
    final query = await Firestore.instance.collection('Users')
    .document(studentId).get();
    //print("Query $query");
    Map<String, dynamic> data = query.data;
    //print("Data $data");
    String name = data['name'];
    //print("Name $name");
    return name;
  }
}
