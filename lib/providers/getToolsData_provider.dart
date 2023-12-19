import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../api/api_service.dart';
import '../models/getToolsData_DataModel.dart';

class ToolsDataProvider extends ChangeNotifier {
  String _selectedClass = "";
  String _selectedSubject = "";

  String get selectedClass => _selectedClass;
  String get selectedSubject => _selectedSubject;

  set selectedClass(String value) {
    _selectedClass = value;
    notifyListeners();
  }

  set selectedSubject(String value) {
    _selectedSubject = value;
    notifyListeners();
  }

  ApiService _apiService = ApiService();
  ToolsData? _toolsData;
  ToolsData? get toolsData => _toolsData;

  Future<void> fetchToolsData(int userId, int toolsId) async {
    try {
      final response = await _apiService.getToolsData(userId, toolsId);
      _toolsData = ToolsData.fromJson(response);
      notifyListeners();
    } catch (e) {
      // Handle error, log, or show a message
      print("Error fetching tools data: $e");
    }
  }
}
