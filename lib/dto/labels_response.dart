class LabelResponse {
  List<Label> labels;

  LabelResponse({required this.labels});

  factory LabelResponse.fromJson(Map<String, dynamic> json) {
    var labelList = json['response'] as List;
    List<Label> labels = labelList.map((label) => Label.fromJson(label)).toList();
    return LabelResponse(labels: labels);
  }
}

class Label {
  int labelId;
  String name;

  Label({required this.labelId, required this.name});

  factory Label.fromJson(Map<String, dynamic> json) {
    return Label(
      labelId: json['labelId'],
      name: json['name'],
    );
  }
}
