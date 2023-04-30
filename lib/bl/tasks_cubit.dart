import 'package:flutter_bloc/flutter_bloc.dart';
import '../dto/task_response.dart';
import '../services/tasks_service.dart';
import 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit() : super(TasksState());

  Future<void> getTasks() async {
    emit(state.copyWith(status: TasksStatus.loading));
    try {
      final response = await TaskService.getTasks();
      List<Task> tasks = response.tasks;
      emit(state.copyWith(status: TasksStatus.success, tasks: tasks));
    } catch (e) {
      emit(state.copyWith(status: TasksStatus.failure));
    }
  }
}
