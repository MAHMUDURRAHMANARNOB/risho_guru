import 'dart:convert';
import 'package:http/http.dart' as http;
import 'responses/login_response.dart';

class ApiService {
  /*LOGIN*/
  static Future<LoginResponse> loginApi(
      String username, String password) async {
    const apiUrl = 'https://testapi.risho.guru/loginuser/';

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
}
