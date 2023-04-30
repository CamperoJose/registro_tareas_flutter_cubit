import 'dart:convert';
import 'package:registro_tareas_flutter_cubit/dto/api_response.dart';
import 'package:http/http.dart' as http;

import 'endpoints.dart';

class LoginService {

  static Future<ApiResponse> login(String username, String password) async {
  var data = {
    "username": username,
    "password": password
  };

  var body = json.encode(data);

  var response = await http.post(Uri.parse(urlBase + loginEndpoint),
    headers: {
      "Content-Type": "application/json",
      "Accept": "application/json"
    },
    body: body
  );

  if (response.statusCode == 200) {
    return ApiResponse.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to login');
  }
}

}
