import 'dart:convert';
import 'package:flutter_keychain/flutter_keychain.dart';
import 'package:http/http.dart' as http;
import '../dto/task_create_response.dart';
import '../dto/task_response.dart';
import 'endpoints.dart';

class TaskCreateService {
  static Future<NewTaskResponse> createTask(
      String description, String date, List<int> labelIds, bool isDone, String d2) async {
    final authToken = await FlutterKeychain.get(key: "AuthToken");
    print("llega aqui");

    final response = await http.post(
      Uri.parse(urlBase + createTaskEndpoint),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $authToken",
      },
      body: json.encode({
        "description": description,
        "date": date,
        "labelIds": labelIds,
        "isDone": isDone,
        "dateFinish": d2,
      }),
    );


    if (response.statusCode == 200) {
      return NewTaskResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al crear la tarea');
    }
  }
}