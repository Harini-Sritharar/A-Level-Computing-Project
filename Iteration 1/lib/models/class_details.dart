import 'package:nea_prototype_1/main.dart';
import 'package:nea_prototype_1/models/quiz.dart';

class ClassDetails {
  String className = "", subject = "", teacherId = "", classId;
  List<Quiz> quizzes = [];
  List<String> studentIds = [];
  List<String> quizIds = [];
  List<String> studentNames = [];
  ClassDetails(this.classId);
}

  Future<List<ClassDetails>> convertToClassDetailsStructure(
      List<Map<String, dynamic>> classesFetched) async {
    List<ClassDetails> classes = [];
    for (int i = 0; i < classesFetched.length; i++) {
      var currentClass = classesFetched.elementAt(i);
      ClassDetails newClass = ClassDetails(currentClass['classId']);
      newClass.className = currentClass['className'];
      newClass.subject = currentClass['subject'];
      newClass.teacherId = currentClass['teacherId'];
      for (int i = 0; i < currentClass['studentIds'].length;i++ ){
        newClass.studentIds.add(currentClass['studentIds'][i]);
      }
      // for (int i = 0; i < currentClass['quizzes'].length;i++ ){
      //   newClass.quizzes.add(currentClass['quizzes'][i]);
      // }
      for (int i = 0; i < currentClass['studentIds'].length;i++ ){
       String name = await databaseService.fetchStudentName(currentClass['studentIds'][i]);
        newClass.studentNames.add(name);
      }
      // for (int i = 0; i < currentClass['quizIds']; i++){
      //   newClass.quizzes.add()
      // }
      // for (int i = 0; i < currentClass['quizzes'].length;i++ ){
      //  String name = await databaseService.fetchStudentName(currentClass['studentIds'][i]);
      //   newClass.studentNames.add(name);
      // }
      //newClass.quizzes = currentClass['quizzes'];
      //newClass.studentIds = currentClass['studentIds'];
      classes.add(newClass);
    }
    return classes;
  }
