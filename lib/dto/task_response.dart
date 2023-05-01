class TaskResponse {
  List<Task> tasks;

  TaskResponse({required this.tasks});

  factory TaskResponse.fromJson(Map<String, dynamic> json) {
    var taskList = json['response'] as List;
    List<Task> tasks = taskList.map((task) => Task.fromJson(task)).toList();
    return TaskResponse(tasks: tasks);
  }

  factory TaskResponse.fromTaskJson(Map<String, dynamic> json) {
    return TaskResponse(tasks: [Task.fromJson(json["response"])]);
  }
}

class Task {
  int taskId;
  String description;
  String date;
  List<int> labelIds;
  bool isDone;
  String dateFinish;

  Task({
    required this.taskId,
    required this.description,
    required this.date,
    required this.labelIds,
    required this.isDone,
    required this.dateFinish,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      taskId: json['taskId'],
      description: json['description'],
      date: json['date'],
      labelIds: List<int>.from(json['labelIds']),
      isDone: json['isDone'],
      dateFinish: json['dateFinish'],
    );
  }

  factory Task.fromUpdateJson(Map<String, dynamic> json) {
    return Task(
      taskId: json['taskId'],
      description: json['description'],
      date: json['date'],
      labelIds: List<int>.from(json['labelIds']),
      isDone: json['isDone'],
      dateFinish: json['dateFinish'],
    );
  }
}
