class LessonModel {
  final int errorCode;
  final String message;
  final LessonAnswer lessonAnswer;

  LessonModel(
      {required this.errorCode,
      required this.message,
      required this.lessonAnswer});

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
      errorCode: json['errorcode'],
      message: json['message'],
      lessonAnswer: LessonAnswer.fromJson(json['lessonanswer']),
    );
  }
}

class LessonAnswer {
  final int answerId;
  final int lessonId;
  final int courseId;
  final String? ansType;
  final String? textAns;
  final String? videoSource;
  final String? linkText;
  final int? likeCount;
  final int? dislikeCount;
  final int? inappropriate;
  final int? audioSegments;
  final String? audioLink;
  // Add other fields as needed

  LessonAnswer({
    required this.answerId,
    required this.lessonId,
    required this.courseId,
    required this.ansType,
    required this.textAns,
    required this.videoSource,
    required this.linkText,
    required this.likeCount,
    required this.dislikeCount,
    required this.inappropriate,
    required this.audioSegments,
    required this.audioLink,
    // Add other fields as needed
  });

  factory LessonAnswer.fromJson(Map<String, dynamic> json) {
    return LessonAnswer(
      answerId: json['answerid'],
      lessonId: json['lessonid'],
      courseId: json['courseID'],
      ansType: json['Anstype'],
      textAns: json['TextAns'],
      videoSource: json['VideoSource'],
      linkText: json['linktext'],
      likeCount:
          json['likecount'] != null ? int.parse(json['likecount']) : null,
      dislikeCount:
          json['dislikecount'] != null ? int.parse(json['likecount']) : null,
      inappropriate: json['Inappropriate'],
      audioSegments: json['Audio_segments'],
      audioLink: json['audio_link'],
      // Parse other fields as needed
    );
  }
}
