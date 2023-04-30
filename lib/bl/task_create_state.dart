import 'package:equatable/equatable.dart';

enum TaskCreateStatus { init, loading, success, failure }

class TaskCreateState extends Equatable {
  final TaskCreateStatus status;

  const TaskCreateState({
    this.status = TaskCreateStatus.init,
  });

  TaskCreateState copyWith({
    TaskCreateStatus? status,
  }) {
    return TaskCreateState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];
}
