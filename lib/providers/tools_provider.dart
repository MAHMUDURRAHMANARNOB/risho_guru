import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../api/api_service.dart';
import '../models/tools.dart';

class ToolsProvider extends ChangeNotifier {
  List<StudyTool> _tools = [];
  int userId;
  ToolsProvider({required this.userId});

  List<StudyTool> get tools => _tools;

  Future<void> fetchTools() async {
    print('Fetching tools for userId: $userId');
    try {
      final tools = await ApiService.fetchTools(userId);
      _tools = tools;
      notifyListeners();
    } catch (error) {
      print('Error fetching tools: $error');
      throw Exception(
          'Failed to load study tools. Check your network connection.');
    }
  }
}
