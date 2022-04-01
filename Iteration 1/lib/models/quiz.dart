import 'package:nea_prototype_1/models/questionInfo.dart';
class Quiz{
  // parameters for the class
  String quizTitle;
  String quizId;
  List<QuestionInfo> questions = [];
  // constructor for the class

  Quiz(this.quizTitle, this.quizId,this.questions);

  @override
  // function which converts the values provided to a String

  String toString(){
    return quizId;
  }
}
  // function which converts the information fetched from Firebase into the structure of Quiz
  List<Quiz> convertToQuizStructure(List<Map<String,dynamic>> quizzesFetched){
    List<Quiz> quizzes = [];
  for (int i = 0; i < quizzesFetched.length; i++) {
    var quiz = quizzesFetched.elementAt(i);
    Quiz newQuiz = Quiz(quiz['quizTitle'],quiz['quizId'], []);
    quizzes.add(newQuiz);
  }
    return quizzes;
  }
