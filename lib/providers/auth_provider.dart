// providers/auth_provider.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import '../api/api_service.dart';
import '../api/responses/login_response.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  Future<void> login(String username, String password) async {
    try {
      // Call the loginApi method from the ApiService
      LoginResponse loginResponse =
          await ApiService.loginApi(username, password);

      // Process the API response
      if (loginResponse.errorCode == 200) {
        _user = User(
          id: loginResponse.id,
          userID: loginResponse.userID,
          username: loginResponse.username,
          name: loginResponse.name,
          email: loginResponse.email,
          mobile: loginResponse.mobile,
          password: loginResponse.password,
          userType: loginResponse.userType,
        );

        // Notify listeners to trigger a rebuild in the UI
        notifyListeners();
      } else {
        // Handle unsuccessful login
        print(
            "Login failed. ErrorCode: ${loginResponse.errorCode}, Message: ${loginResponse.message}");
      }
    } catch (error) {
      // Handle errors from the ApiService
      print("Error during login: $error");
    }
  }
}
