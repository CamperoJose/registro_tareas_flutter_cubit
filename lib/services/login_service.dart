import 'dart:convert';
import 'package:registro_tareas_flutter_cubit/dto/api_response.dart';
import 'package:registro_tareas_flutter_cubit/services/endpoints.dart';
import 'package:http/http.dart' as http;

class LoginService {
  static Future<ApiResponse> login(String username, String password) async {
    var response = await http.post(Uri.parse(urlBase + loginEndpoint),
    body:{
      "username": username,
      "password": password
    }
    );

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to login');
    }
  }
}
