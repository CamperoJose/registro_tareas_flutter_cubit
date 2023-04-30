class TaskResponse {
  List<Task> tasks;
  
  TaskResponse({required this.tasks});
  
  factory TaskResponse.fromJson(Map<String, dynamic> json) {
    var taskList = json['response'] as List;
    List<Task> tasks = taskList.map((task) => Task.fromJson(task)).toList();
    return TaskResponse(tasks: tasks);
  }
}

class Task {
  int taskId;
  String description;
  String date;
  List<int> labelIds;
  
  Task({
    required this.taskId,
    required this.description,
    required this.date,
    required this.labelIds,
  });
  
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      taskId: json['taskId'],
      description: json['description'],
      date: json['date'],
      labelIds: List<int>.from(json['labelIds']),
    );
  }
}