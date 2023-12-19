import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../api/api_service.dart';
import '../models/getToolsResponseDataModel.dart';

class ToolsResponseProvider extends ChangeNotifier {
  ApiService _apiService = ApiService();

  ToolsResponseDataModel? _toolsResponse;
  ToolsResponseDataModel? get toolsResponse => _toolsResponse;

  Future<void> fetchToolsResponse(int userId, String questionText,
      String subject, String gradeClass, String toolsCode) async {
    print("inside fetchToolsResponse");
    try {
      final response = await _apiService.getToolsResponse(
        userId,
        questionText,
        subject,
        gradeClass,
        toolsCode,
      );
      _toolsResponse = ToolsResponseDataModel.fromJson(response);
      print("Response from fetchToolsResponse: $response");
      notifyListeners();
    } catch (error) {
      print('Error in getToolsResponse: $error');
      throw Exception('Failed to load data. Check your network connection.');
    }
  }
}
