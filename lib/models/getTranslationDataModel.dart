class TranslationModel {
  final int errorCode;
  final String message;
  final Translation traslation;

  TranslationModel(
      {required this.errorCode,
      required this.message,
      required this.traslation});

  factory TranslationModel.fromJson(Map<String, dynamic> json) {
    return TranslationModel(
      errorCode: json['errorcode'],
      message: json['message'],
      traslation: Translation.fromJson(json['traslation']),
    );
  }
}

class Translation {
  final int TranslationId;
  final int lessonanswerid;
  final String? TextAnsBn;

  // Add other fields as needed

  Translation({
    required this.TranslationId,
    required this.lessonanswerid,
    required this.TextAnsBn,

    // Add other fields as needed
  });

  factory Translation.fromJson(Map<String, dynamic> json) {
    return Translation(
      TranslationId: json['TranslationId'],
      lessonanswerid: json['lessonanswerid'],
      TextAnsBn: json['TextAnsBn'],

      // Parse other fields as needed
    );
  }
}
