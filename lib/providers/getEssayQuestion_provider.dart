import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../api/api_service.dart';
import '../models/getEssayQuestionDataModel.dart';

class EssayQuestionProvider extends ChangeNotifier {
  ApiService _apiService = ApiService();

  EssayQuestionDataModel? _essayQuestionDataModel;
  EssayQuestionDataModel? get essayQuestionResponse => _essayQuestionDataModel;

  Future<void> fetchEssayQuestionResponse(int lessonId) async {
    print("inside fetchEssayQuestion");
    try {
      final response = await _apiService.getEssayQuestions(lessonId);
      _essayQuestionDataModel = EssayQuestionDataModel.fromJson(response);
      print("Response from fetchEssayQuestionResponse: $response");
      notifyListeners();
    } catch (error) {
      print('Error in fetchEssayQuestionResponse: $error');
      throw Exception('Failed to load data. Check your network connection.');
    }
  }
}
