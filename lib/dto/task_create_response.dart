class TaskListResponse {
  final String code;
  final List<Task> tasks;
  final String? errorMessage;

  TaskListResponse({
    required this.code,
    required this.tasks,
    this.errorMessage,
  });

  factory TaskListResponse.fromJson(Map<String, dynamic> json) {
    var taskList = json['response'] as List;
    List<Task> tasks = taskList.map((task) => Task.fromJson(task)).toList();
    return TaskListResponse(
      code: json['code'],
      tasks: tasks,
      errorMessage: json['errorMessage'],
    );
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

class NewTaskResponse {
  final String code;
  final String response;
  final String? errorMessage;

  NewTaskResponse({
    required this.code,
    required this.response,
    this.errorMessage,
  });

  factory NewTaskResponse.fromJson(Map<String, dynamic> json) {
    return NewTaskResponse(
      code: json['code'],
      response: json['response'],
      errorMessage: json['errorMessage'],
    );
  }
}
