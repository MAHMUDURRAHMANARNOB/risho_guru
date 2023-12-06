import 'package:flutter/material.dart';
import 'package:risho_guru/api/api_service.dart';
import '../api/responses/SubscribedCoursesResponse.dart';
import '../models/course.dart';

class CourseProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  int userId = 59317;
  List<Course>? _courses;
  List<Course>? get courses => _courses;

  CourseProvider({required this.userId});

  // Add a method to fetch courses from your API
  Future<void> fetchCourses() async {
    try {
      /*userId = 1;*/
      _courses = await _apiService.fetchSubscribedCourses(userId);
      notifyListeners();
    } catch (error) {
      print('Error fetching courses: $error');
      // Handle error as needed
    }
  }
}