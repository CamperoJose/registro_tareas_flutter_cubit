import 'package:equatable/equatable.dart';
import 'package:registro_tareas_flutter_cubit/dto/labels_response.dart';
import '../dto/task_response.dart';

enum TasksStatus { init, loading, success, failure }

class TasksState extends Equatable {
  final TasksStatus status;
  final List<Task> tasks;
  final List<Label> labels;
  final Task? editingTask;
  final String editingTaskDescription;
  final String editingTaskDate;

  const TasksState({
    this.status = TasksStatus.init,
    this.tasks = const [],
    this.labels = const [],
    this.editingTask,
    this.editingTaskDescription = '',
    this.editingTaskDate = '',
  });

  TasksState copyWith({
    TasksStatus? status,
    List<Task>? tasks,
    List<Label>? labels,
    Task? editingTask,
    String? editingTaskDescription,
    String? editingTaskDate,
  }) {
    return TasksState(
      status: status ?? this.status,
      tasks: tasks ?? this.tasks,
      labels: labels ?? this.labels,
      editingTask: editingTask ?? this.editingTask,
      editingTaskDescription:
          editingTaskDescription ?? this.editingTaskDescription,
      editingTaskDate: editingTaskDate ?? this.editingTaskDate,
    );
  }

  @override
  List<Object?> get props => [
        status,
        tasks,
        labels,
        editingTask,
        editingTaskDescription,
        editingTaskDate,
      ];
}
