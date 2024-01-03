class EssayQuestionDataModel {
  int errorCode;
  String message;
  List<Question> questionList;

  EssayQuestionDataModel(
      {required this.errorCode,
      required this.message,
      required this.questionList});

  factory EssayQuestionDataModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> questionsData = json['questionlist'];

    List<Question> questions = questionsData.map((question) {
      return Question.fromJson(question);
    }).toList();

    return EssayQuestionDataModel(
      errorCode: json['errorcode'],
      message: json['message'],
      questionList: questions,
    );
  }
}

class Question {
  int questionID;
  int courseId;
  int chapterId;
  int lessonId;
  String questionText;
  String ansText;
  int? likeCount;
  int? dislikeCount;
  String markedInp;

  Question({
    required this.questionID,
    required this.courseId,
    required this.chapterId,
    required this.lessonId,
    required this.questionText,
    required this.ansText,
    this.likeCount,
    this.dislikeCount,
    required this.markedInp,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      questionID: json['questionID'],
      courseId: json['CourseId'],
      chapterId: json['ChapterId'],
      lessonId: json['lessonId'],
      questionText: json['QuestionText'],
      ansText: json['AnsText'],
      likeCount: json['Likecount'],
      dislikeCount: json['dislikecount'],
      markedInp: json['markedinp'],
    );
  }
}
