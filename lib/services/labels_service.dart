import 'dart:convert';
import 'package:flutter_keychain/flutter_keychain.dart';
import 'package:http/http.dart' as http;
import '../dto/labels_response.dart';
import 'endpoints.dart';

class LabelService {
  static Future<LabelResponse> getLabels() async {
    final authToken = await FlutterKeychain.get(key: "AuthToken");
    final response = await http.get(
      Uri.parse(urlBase + listLabelsEndpoint),
      headers: {
        "Authorization": "Bearer $authToken",
      },
    );

    if (response.statusCode == 200) {
      return LabelResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al obtener las etiquetas');
    }
  }
}
