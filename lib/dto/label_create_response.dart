class NewLabelResponse {
  final String code;
  final String response;
  final String? errorMessage;

  NewLabelResponse({
    required this.code,
    required this.response,
    this.errorMessage,
  });

  factory NewLabelResponse.fromJson(Map<String, dynamic> json) {
    return NewLabelResponse(
      code: json['code'],
      response: json['response'],
      errorMessage: json['errorMessage'],
    );
  }
}
