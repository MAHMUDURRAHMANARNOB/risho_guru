import 'package:flutter/material.dart';
import '../api/api_service.dart';
import '../models/getTranslationDataModel.dart';

class TranslationProvider extends ChangeNotifier {
  ApiService _apiService = ApiService();
  TranslationModel? _translationModel;

  TranslationModel? get translationModel => _translationModel;

  Future<void> fetchTranslationData(int lessonanswerid) async {
    print("inside fetchTranslationData");
    try {
      final response = await _apiService.getTranslation(lessonanswerid);
      _translationModel = TranslationModel.fromJson(response);
      print("Response from TranslationProvider: $response");
      notifyListeners();
    } catch (e) {
      print('Error in TranslationProvider: $e');
    }
  }
}
