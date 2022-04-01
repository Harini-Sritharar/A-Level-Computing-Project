class QuestionInfo {
  // parameters for the class
  final String questionName;
  final String correctOption;
  final List<String> incorrectOptions;
  // constructor for the class
  QuestionInfo(this.questionName,this.correctOption,this.incorrectOptions,);

  @override
  // function which converts the values provided to a String
  String toString(){
    return "--,$questionName,$correctOption,$incorrectOptions";
  }
}