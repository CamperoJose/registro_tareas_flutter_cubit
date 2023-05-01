import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:registro_tareas_flutter_cubit/services/labels_service.dart';
import '../dto/labels_response.dart';
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

  Future<void> updateTask(int taskId, String description, String date, List<int> labelIds, bool isDone, String date2) async { // Agregar función para actualizar tarea
    emit(state.copyWith(status: TasksStatus.loading));
    try {
      final updatedTask = await TaskService.updateTask(
        taskId,
        description,
        date,
        labelIds,
        isDone,
        date2,
      );
      final response = await TaskService.getTasks();
      List<Task> tasks = response.tasks;
      emit(state.copyWith(status: TasksStatus.success, tasks: tasks));
    } catch (e) {
      emit(state.copyWith(status: TasksStatus.failure));
    }
  }

}
