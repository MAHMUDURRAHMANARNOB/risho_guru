class StudyTool {
  final int toolID;
  final String toolName;
  final String? descriptions;
  final String classField;
  final String subject;
  final String maxWord;
  final String question2;
  final String mathKeyboard;
  final String chapters;
  final String toolsCode;

  StudyTool({
    required this.toolID,
    required this.toolName,
    required this.descriptions,
    required this.classField,
    required this.subject,
    required this.maxWord,
    required this.question2,
    required this.mathKeyboard,
    required this.chapters,
    required this.toolsCode,
  });

  factory StudyTool.fromJson(Map<String, dynamic> json) {
    return StudyTool(
      toolID: json['ToolID'],
      toolName: json['toolname'],
      descriptions: json['descriptions'],
      classField: json['class'],
      subject: json['subject'],
      maxWord: json['maxword'],
      question2: json['question2'],
      mathKeyboard: json['mathkeyboard'],
      chapters: json['chapters'],
      toolsCode: json['toolsCode'],
    );
  }
}
