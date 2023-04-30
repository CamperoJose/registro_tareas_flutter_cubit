import 'dart:convert';
import 'package:flutter_keychain/flutter_keychain.dart';
import 'package:http/http.dart' as http;
import '../dto/label_create_response.dart';
import 'endpoints.dart';

class LabelCreateService {
  static Future<NewLabelResponse> createLabel(
      String name, String date) async {
    final authToken = await FlutterKeychain.get(key: "AuthToken");

    final response = await http.post(
      Uri.parse(urlBase + createLabelEndpoint),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $authToken",
      },
      body: json.encode({
        "name": name,
        "date": date,
      }),
    );

    if (response.statusCode == 200) {
      return NewLabelResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al crear la etiqueta');
    }
  }
}
