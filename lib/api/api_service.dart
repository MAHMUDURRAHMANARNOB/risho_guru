import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:risho_guru/api/responses/SubscribedCoursesResponse.dart';
import 'package:risho_guru/api/responses/substiptionStatus_response.dart';
import '../models/course.dart';
import '../models/tools.dart';
import 'responses/login_response.dart';

class ApiService {
  static const String baseUrl = 'https://testapi.risho.guru';
  /*LOGIN*/
  static Future<LoginResponse> loginApi(
      String username, String password) async {
    const apiUrl = '$baseUrl/loginuser/';

    /*for query type url*/
    final Uri uri = Uri.parse('$apiUrl?userid=$username&password=$password');

    /*json type url*/
    /*final response = await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
      headers: {'Content-Type': 'application/json'},
    );*/

    /*Query type url*/
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the response body
      return LoginResponse.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception or handle the error as needed
      throw Exception('Failed to load data');
    }
  }

  /*TOOLS LIST*/
  static Future<List<StudyTool>> fetchTools(int userId) async {
    const apiUrl = '$baseUrl/gettoolslist/';
    final Uri uri = Uri.parse(apiUrl);

    final response = await http.post(
      uri,
      body: {'userid': userId.toString()},
    );

    try {
      if (response.statusCode == 200) {
        final dynamic responseData = jsonDecode(response.body);
        print("reponse $responseData");

        if (responseData != null && responseData['studytools'] != null) {
          final List<dynamic> toolsData = responseData['studytools'];
          return toolsData.map((data) => StudyTool.fromJson(data)).toList();
        } else {
          throw Exception('Invalid response format');
        }

        /*final List<dynamic> responseData =
          jsonDecode(response.body)['studytools'];
      return responseData.map((data) => StudyTool.fromJson(data)).toList();*/
      } else {
        throw Exception(
            'Failed to load study tools. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to load study tools. Error: $error');
    }
  }

  /*SUBSCRIPTION STATUS*/
  static Future<SubscriptionStatusResponse> fetchSubscriptionStatus(
      int userId) async {
    const apiUrl = '$baseUrl/getsubscriptionstatus/';
    final Uri uri = Uri.parse('$apiUrl');
    final response = await http.post(
      uri,
      body: {'userid': userId.toString()},
      /*headers: {'Content-Type': 'application/json'},*/
    );

    if (response.statusCode == 200) {
      print(SubscriptionStatusResponse.fromJson(jsonDecode(response.body)));
      return SubscriptionStatusResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Sub status');
    }
  }

  /*Subscribed COURSES*/
  Future<List<Course>> fetchSubscribedCourses(int userId) async {
    const apiUrl = '$baseUrl/getsubscribedcourse/';
    final Uri uri = Uri.parse(apiUrl);

    final response = await http.post(
      uri,
      body: {'userid': userId.toString()},
    );
    print("response: " + json.decode(response.body));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      print('API Response fetchSubscribedCourses: $jsonData');
      final courses = (jsonData['courseinfo'] as List)
          .map((courseJson) => Course.fromJson(courseJson))
          .toList();
      // Print the courses for debugging
      print('Parsed Courses: $courses');

      return courses;
    } else {
      throw Exception('Failed to load data');
    }
  }

  /*Subscribed COURSES*/
  /*static Future<List<Course>> fetchSubscribedCourses(
    int userId,
  ) async {
    const apiUrl = '$baseUrl/getsubscribedcourse/';
    final Uri uri = Uri.parse(apiUrl);

    final response = await http.post(
      uri,
      body: {'userid': userId.toString()},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      List<Course> courses =
          data.map((courseJson) => Course.fromJson(courseJson)).toList();
      return courses;
      */ /*final Map<String, dynamic> json = jsonDecode(response.body);
      return SubscribedCoursesResponse.fromJson(json);*/ /*
      */ /*SubscribedCoursesResponse.fromJson(jsonDecode(response.body));*/ /*
    } else {
      throw Exception('Failed to load subscribed courses');
    }
  }*/
}
