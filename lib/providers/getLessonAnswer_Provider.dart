import 'package:flutter/material.dart';

import '../api/api_service.dart';
import '../models/getLessonAnswer.dart';

class LessonAnswerProvider extends ChangeNotifier {
  ApiService _apiService = ApiService();
  LessonModel? _lessonModel;

  LessonModel? get lessonModel => _lessonModel;

  Future<void> fetchLessonData(int lessonId, int courseId, int userId) async {
    print("$lessonId ____ $courseId ____ $userId");
    try {
      final response =
          await _apiService.getLessonAnswer(lessonId, courseId, userId);
      _lessonModel = LessonModel.fromJson(response);
      print("response form lessonAnswerProvider: $response");
      notifyListeners();
    } catch (e) {
      // Handle error
      print('Error in provider: $e');
    }
  }
}
