import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
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
    print("Response $response");

    if (response.statusCode == 200) {
      print(SubscriptionStatusResponse.fromJson(jsonDecode(response.body)));
      return SubscriptionStatusResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Sub status');
    }
  }

  /*SUBSCRIBED COURSES*/
  Future<List<Course>> fetchSubscribedCourses(int userId) async {
    const apiUrl = '$baseUrl/getsubscribedcourse/';
    print("apiUrl: " + apiUrl);
    final Uri uri = Uri.parse(apiUrl);

    final response = await http.post(
      uri,
      body: {'userid': userId.toString()},
    );

    if (response.statusCode == 200) {
      final dynamic coursesresponseData = json.decode(response.body);
      print('API Response fetchSubscribedCourses: $coursesresponseData');
      final message = (coursesresponseData["message"]);
      print('message: $message');
      final List<dynamic> courses = coursesresponseData['courseinfo'];
      // Print the courses for debugging
      print('Parsed Courses: $courses');

      final List<Course> parsedCourses =
          courses.map((data) => Course.fromJson(data)).toList();

      return parsedCourses;
    } else {
      throw Exception('Failed to load data');
    }
  }

  /*GET LESSON ANSWER*/
  Future<Map<String, dynamic>> getLessonAnswer(
      int lessonId, int courseId, int userId) async {
    final url = '$baseUrl/getlessonanswer/';
    print("Posting in api service $url, $lessonId, $courseId , $userId");
    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'lessonid': lessonId.toString(),
          'courseid': courseId.toString(),
          'userid': userId.toString(),
        },
      );
      print("Response  $response");
      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        print("Response in api service " + response.body);
        return json.decode(response.body);
      } else {
        // If the server did not return a 200 OK response, throw an exception.
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  /*Translation*/
  Future<Map<String, dynamic>> getTranslation(int lessonanswerid) async {
    final url = '$baseUrl/gettranslation/';
    print("Posting in api service $url, $lessonanswerid");
    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'lessonanswerid': lessonanswerid.toString(),
        },
      );
      print("Response  $response");
      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        print("Response in getTranslation " + response.body);
        return json.decode(Utf8Decoder().convert(response.bodyBytes));
      } else {
        // If the server did not return a 200 OK response, throw an exception.
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  /*TAKE EXAM*/
  Future<Map<String, dynamic>> getMCQExamQuestions(
      int lessonid, String requestfor) async {
    final url = '$baseUrl/getmcqquestions/';
    print("Posting in api service $url, $lessonid");
    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'lessonorvideoid': lessonid.toString(),
          'requestfor  ': requestfor.toString(),
        },
      );
      print("Response  $response");
      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        print("Response in getMCQExamQuestions " + response.body);
        return json.decode(response.body);
      } else {
        // If the server did not return a 200 OK response, throw an exception.
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  /*Essay Question*/
  Future<Map<String, dynamic>> getEssayQuestions(int lessonid) async {
    final url = '$baseUrl/getessayquestion/';
    print("Posting in api service $url, $lessonid");
    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'lessonid': lessonid.toString(),
        },
      );
      print("Response  $response");
      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        print("Response in getEssayQuestions " + response.body);
        return json.decode(response.body);
      } else {
        // If the server did not return a 200 OK response, throw an exception.
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  /*Submit Reaction*/
  Future<Map<String, dynamic>> getSubmitReaction(int userid, int reactingid,
      String reactiontype, String reactionfor) async {
    final url = '$baseUrl/submitreaction/';
    print(
        "Posting in api service $url, $userid, $reactingid, $reactiontype, $reactionfor");
    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'vuserid': userid.toString(),
          'reactingid': reactingid.toString(),
          'reactiontype': reactiontype.toString(),
          'reactionfor': reactionfor.toString(),
        },
      );
      print("Response  $response");
      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        print("Response in getSubmitReaction " + response.body);
        return json.decode(response.body);
      } else {
        // If the server did not return a 200 OK response, throw an exception.
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  /*Tools Response*/
  Future<Map<String, dynamic>> getToolsResponse(
      int userid,
      String questiontext,
      String subject,
      String gradeclass,
      String toolscode,
      String maxline,
      String isMobile) async {
    final url = '$baseUrl/gettoolsresponse/';
    print(
        "Posting in api service $url, $userid, $questiontext, $subject, $gradeclass, $toolscode");
    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'userid': userid.toString(),
          'questiontext': questiontext.toString(),
          'subject': subject.toString(),
          'gradeclass': gradeclass.toString(),
          'toolscode': toolscode.toString(),
          'maxSentence': maxline.toString(),
          'isMobileApp': isMobile.toString(),
        },
      );
      print("Response  $response");
      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        print("Response in getToolsResponse " + response.body);
        return json.decode(response.body);
      } else {
        // If the server did not return a 200 OK response, throw an exception.
        throw Exception('Failed to load data in getToolsResponse');
      }
    } catch (e) {
      throw Exception("Failed getToolsResponse $e");
    }
  }

  /*IMAGE TOOLS RESPONSE*/
  Future<Map<String, dynamic>> getImageToolsResponse(
      File questionImage,
      int userid,
      String questiontext,
      String subject,
      String gradeclass,
      String toolscode,
      String maxline,
      String isMobile) async {
    final url = '$baseUrl/getimagetoolsresponse/';
    print(
        "Posting in api service $url $questionImage ,$userid, $questiontext, $subject, $gradeclass, $toolscode");
    /*try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'questionimage': questionimage.toString(),
          'userid': userid.toString(),
          'questiontext': questiontext.toString(),
          'subject': subject.toString(),
          'gradeclass': gradeclass.toString(),
          'toolscode': toolscode.toString(),
          'maxSentence': maxline.toString(),
          'isMobileApp': isMobile.toString(),
        },
      );
      print("Response  $response");
      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        print("Response in getToolsResponse " + response.body);
        return json.decode(response.body);
      } else {
        // If the server did not return a 200 OK response, throw an exception.
        throw Exception('Failed to load data in getToolsResponse');
      }
    } catch (e) {
      throw Exception("Failed getToolsResponse $e");
    }*/
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['userid'] = userid.toString();
      request.fields['questiontext'] = questiontext.toString();
      request.fields['subject'] = subject.toString();
      request.fields['gradeclass'] = gradeclass.toString();
      request.fields['toolscode'] = toolscode.toString();
      request.fields['maxSentence'] = maxline.toString();
      request.fields['isMobileApp'] =
          isMobile.toString() == null ? isMobile.toString() : "50";
      request.files.add(await http.MultipartFile.fromPath(
          'questionimage', questionImage.path));
      print("QUESTIONIMAGEPATH: ${questionImage.path}");

      final response = await request.send();

      if (response.statusCode == 200) {
        print('Image uploaded successfully');
        print("Response in getToolsResponse " +
            await response.stream.bytesToString());
      } else {
        print('Failed to upload image. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading image: $e');
      throw Exception("Failed getToolsResponse $e");
    }
    return {};
  }

  /*GET TOOLS DATA*/
  Future<Map<String, dynamic>> getToolsData(int userid, int ToolsID) async {
    final url = '$baseUrl/gettoolsdata/';
    print("Posting in api service $url, $userid, $ToolsID");
    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'userid': userid.toString(),
          'ToolsID': ToolsID.toString(),
        },
      );
      print("Response  $response");
      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        print("Response in getToolsData " + response.body);
        return json.decode(response.body);
      } else {
        // If the server did not return a 200 OK response, throw an exception.
        throw Exception('Failed to load data in getToolsData');
      }
    } catch (e) {
      throw Exception("Failed getToolsData $e");
    }
  }
}
