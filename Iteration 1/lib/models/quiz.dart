import 'package:nea_prototype_1/models/questionInfo.dart';

class Quiz{
  String quizTitle;
  String quizId;
  List<QuestionInfo> questions = [];
  Quiz(this.quizTitle, this.quizId,this.questions)
}

