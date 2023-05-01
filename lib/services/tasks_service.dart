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

  static Future<Task> updateTask(int taskId, String description, String date, List<int> labelIds, bool isDone, String date2) async {
  final authToken = await FlutterKeychain.get(key: "AuthToken");
  final response = await http.put(
    Uri.parse(urlBase + updateTaskEndpoint.replaceFirst("{taskId}", taskId.toString())),
    headers: {
      "Authorization": "Bearer $authToken",
      "Content-Type": "application/json",
      "Accept": "application/json",
    },
    body: jsonEncode({
      "description": description,
      "date": date,
      "labelIds": labelIds,
      "isDone": isDone,
      "dateFinish": date2,
    }),
  );

  if (response.statusCode == 200) {
    return Task.fromJson(json.decode(response.body)["response"]);
  } else {
    throw Exception('Error al actualizar la tarea');
  }
}

}
