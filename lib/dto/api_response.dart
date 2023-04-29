import 'auth_response.dart';

class ApiResponse {
  String code;
  AuthResponse response;
  String errorMessage;

  ApiResponse({
    required this.code,
    required this.response,
    required this.errorMessage,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
  return ApiResponse(
    code: json['code'],
    response: AuthResponse.fromJson(json['response']),
    errorMessage: json['errorMessage'] ?? '', // si el campo errorMessage es null, establecerlo en una cadena vacía
  );
}


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = code;
    data['response'] = response.toJson();
    data['errorMessage'] = errorMessage;
    return data;
  }
}
