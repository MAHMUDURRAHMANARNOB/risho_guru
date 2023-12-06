import '../../models/course.dart';

class SubscribedCoursesResponse {
  final int errorCode;
  final String message;
  final List<Course> courseInfo;

  SubscribedCoursesResponse({
    required this.errorCode,
    required this.message,
    required this.courseInfo,
  });

  factory SubscribedCoursesResponse.fromJson(Map<String, dynamic> json) {
    return SubscribedCoursesResponse(
      errorCode: json['errorcode'],
      message: json['message'],
      courseInfo: (json['courseinfo'] as List<dynamic>)
          .map((courseJson) => Course.fromJson(courseJson))
          .toList(),
    );
  }
}
