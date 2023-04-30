import 'dart:convert';
import 'package:flutter_keychain/flutter_keychain.dart';
import 'package:http/http.dart' as http;
import '../dto/task_response.dart';
import 'endpoints.dart';

class TaskService {
  static Future<TaskResponse> getTasks() async {
    final authToken = await FlutterKeychain.get(key: "AuthToken");
    final response = await http.get(
      Uri.parse(urlBase + listTasksEndpoint),
      headers: {
        "Authorization": "Bearer $authToken",
      },
    );

    if (response.statusCode == 200) {
      return TaskResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al obtener las tareas');
    }
  }
}
