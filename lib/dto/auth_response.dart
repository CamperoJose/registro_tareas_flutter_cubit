class AuthResponse {
  String authToken;
  String refreshToken;

  AuthResponse({required this.authToken, required this.refreshToken});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      authToken: json['authToken'],
      refreshToken: json['refreshToken'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }

}
