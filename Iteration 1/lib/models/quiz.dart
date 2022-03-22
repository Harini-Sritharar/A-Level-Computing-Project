import 'package:nea_prototype_1/models/questionInfo.dart';

class Quiz{
  String quizTitle;
  String quizId;
  List<QuestionInfo> questions = [];
  Quiz(this.quizTitle, this.quizId,this.questions);

  @override
  String toString(){
    return quizId;
  }
}
  List<Quiz> convertToQuizStructure(List<Map<String,dynamic>> quizzesFetched){
    List<Quiz> quizzes = [];
  for (int i = 0; i < quizzesFetched.length; i++) {
    var quiz = quizzesFetched.elementAt(i);
    Quiz newQuiz = Quiz(quiz['quizTitle'],quiz['quizId'], []);
    quizzes.add(newQuiz);
  }
    return quizzes;
  }