import 'package:nea_prototype_1/models/quiz.dart';

class ClassDetails {
  String className = "", subject = "", teacherId = "", classId;
  List<Quiz> quizzes = [];
  List<String> studentIds = [];

  ClassDetails(this.classId);
}

  List<ClassDetails> convertToClassDetailsStructure(
      List<Map<String, dynamic>> classesFetched) {
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
      //newClass.quizzes = currentClass['quizzes'];
      //newClass.studentIds = currentClass['studentIds'];

      classes.add(newClass);
    }
    return classes;
  }
