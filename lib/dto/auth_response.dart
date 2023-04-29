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

  getAuthToken(){
    return authToken;
  }

  getRefreshToken(){
    return refreshToken;
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['authToken'] = authToken;
  data['refreshToken'] = refreshToken;
  return data;
}

}
