import 'package:equatable/equatable.dart';
import '../dto/task_response.dart';

enum TasksStatus { init, loading, success, failure }

class TasksState extends Equatable {
  final TasksStatus status;
  final List<Task> tasks;

  const TasksState({
    this.status = TasksStatus.init,
    this.tasks = const [],
  });

  TasksState copyWith({
    TasksStatus? status,
    List<Task>? tasks,
  }) {
    return TasksState(
      status: status ?? this.status,
      tasks: tasks ?? this.tasks,
    );
  }

  @override
  List<Object?> get props => [status, tasks];
}
