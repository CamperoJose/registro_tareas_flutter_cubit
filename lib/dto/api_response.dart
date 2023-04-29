import 'auth_response.dart';

class ApiResponse {
  String code;
  AuthResponse reponse;
  String errorMessage;

  ApiResponse({required this.code, required this.reponse, required this.errorMessage});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      code: json['code'],
      reponse: AuthResponse.fromJson(json['response']),
      errorMessage: json['errorMessage'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = code;
    data['response'] = reponse.toJson();
    data['errorMessage'] = errorMessage;
    return data;
  }

}
