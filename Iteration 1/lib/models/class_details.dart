import 'package:nea_prototype_1/main.dart';
import 'package:nea_prototype_1/models/quiz.dart';

class ClassDetails {
  // parameters for the class
  String className = "", subject = "", teacherId = "", classId;
  List<Quiz> quizzes = [];
  List<String> studentIds = [];
  List<String> quizIds = [];
  List<String> studentNames = [];
  ClassDetails(this.classId);
}
  // function which converts the information fetched from Firebase into a structure which allows details from the class to be stored locally and easily read
  Future<List<ClassDetails>> convertToClassDetailsStructure(
      List<Map<String, dynamic>> classesFetched) async {
        // empty list of classes
    List<ClassDetails> classes = [];
    for (int i = 0; i < classesFetched.length; i++) {
      // iterates through the list of classes fetched and performs the function on each class
      var currentClass = classesFetched.elementAt(i);
      // asssigns the values fetched from Firebase to the parameters of the class
      ClassDetails newClass = ClassDetails(currentClass['classId']);
      newClass.className = currentClass['className'];
      newClass.subject = currentClass['subject'];
      newClass.teacherId = currentClass['teacherId'];
      for (int i = 0; i < currentClass['studentIds'].length;i++ ){
        newClass.studentIds.add(currentClass['studentIds'][i]);
      }
      for (int i = 0; i < currentClass['studentIds'].length;i++ ){
       String name = await databaseService.fetchStudentName(currentClass['studentIds'][i]);
        newClass.studentNames.add(name);
      }
      classes.add(newClass);
    }
    // returns all the classes that have been converted to the structure of Class Details
    return classes;
  }
