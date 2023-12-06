/*
class Course {
  final int courseId;
  final String courseName;
  final List<Chapter> chapters;

  Course({
    required this.courseId,
    required this.courseName,
    required this.chapters,
  });
  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      courseId: json['courseid'],
      courseName: json['CourseName'],
      chapters: (json['Chapters'] as List<dynamic>)
          .map((chapterJson) => Chapter.fromJson(chapterJson))
          .toList(),
    );
  }
}

class Chapter {
  final int lessonId;
  final int courseId;
  final String lessonTitle;
  final String isChapter;
  final int ansCount;
  final int seqNo;
  final String isActive;
  final int chapterIndex;
  final List<Lesson> lessonList;

  Chapter({
    required this.lessonId,
    required this.courseId,
    required this.lessonTitle,
    required this.isChapter,
    required this.ansCount,
    required this.seqNo,
    required this.isActive,
    required this.chapterIndex,
    required this.lessonList,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      lessonId: json['lessonid'],
      courseId: json['Courseid'],
      lessonTitle: json['Lessontitle'],
      isChapter: json['isChapter'],
      ansCount: json['Anscount'],
      seqNo: json['SeqNo'],
      isActive: json['isactive'],
      chapterIndex: json['chapterIndex'],
      lessonList: (json['lessonlist'] as List<dynamic>)
          .map((lessonJson) => Lesson.fromJson(lessonJson))
          .toList(),
    );
  }
}

class Lesson {
  final int lessonId;
  final int courseId;
  final String lessonTitle;
  final String isChapter;
  final int ansCount;
  final int seqNo;
  final String isActive;
  final int chapterIndex;

  Lesson({
    required this.lessonId,
    required this.courseId,
    required this.lessonTitle,
    required this.isChapter,
    required this.ansCount,
    required this.seqNo,
    required this.isActive,
    required this.chapterIndex,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      lessonId: json['lessonid'],
      courseId: json['Courseid'],
      lessonTitle: json['Lessontitle'],
      isChapter: json['isChapter'],
      ansCount: json['Anscount'],
      seqNo: json['SeqNo'],
      isActive: json['isactive'],
      chapterIndex: json['chapterIndex'],
    );
  }
}
*/

class Course {
  final int courseId;
  final String courseName;
  final String courseDescription;
  final List<Chapter> chapters;

  Course({
    required this.courseId,
    required this.courseName,
    required this.courseDescription,
    required this.chapters,
  });
  factory Course.fromJson(Map<String, dynamic> json) {
    List<Chapter> chapters = [];
    if (json['Chapters'] != null) {
      chapters = (json['Chapters'] as List)
          .map((chapterJson) => Chapter.fromJson(chapterJson))
          .toList();
    }

    return Course(
      courseId: json['courseid'],
      courseName: json['CourseName'],
      courseDescription: json['CourseDescription'],
      chapters: chapters,
    );
  }
}

class Chapter {
  final int lessonId;
  final int courseId;
  final String lessonTitle;
  final String isChapter;
  final int seqNo;
  final String isActive;
  final int chapterIndex;
  final List<Lesson> lessonList;

  Chapter({
    required this.lessonId,
    required this.courseId,
    required this.lessonTitle,
    required this.isChapter,
    required this.seqNo,
    required this.isActive,
    required this.chapterIndex,
    required this.lessonList,
  });
  factory Chapter.fromJson(Map<String, dynamic> json) {
    List<Lesson> lessonList = [];
    if (json['lessonlist'] != null) {
      lessonList = (json['lessonlist'] as List)
          .map((lessonJson) => Lesson.fromJson(lessonJson))
          .toList();
    }

    return Chapter(
      lessonId: json['lessonid'],
      courseId: json['Courseid'],
      lessonTitle: json['Lessontitle'],
      isChapter: json['isChapter'],
      seqNo: json['SeqNo'],
      isActive: json['isactive'],
      chapterIndex: json['chapterIndex'],
      lessonList: lessonList,
    );
  }
}

class Lesson {
  final int lessonId;
  final int courseId;
  final String lessonTitle;
  final String isChapter;
  final int seqNo;
  final String isActive;
  final int chapterIndex;

  Lesson({
    required this.lessonId,
    required this.courseId,
    required this.lessonTitle,
    required this.isChapter,
    required this.seqNo,
    required this.isActive,
    required this.chapterIndex,
  });
  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      lessonId: json['lessonid'],
      courseId: json['Courseid'],
      lessonTitle: json['Lessontitle'],
      isChapter: json['isChapter'],
      seqNo: json['SeqNo'],
      isActive: json['isactive'],
      chapterIndex: json['chapterIndex'],
    );
  }
}