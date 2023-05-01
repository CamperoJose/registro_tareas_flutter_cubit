import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/tasks_create_service.dart';
import 'task_create_state.dart';

class TaskCreateCubit extends Cubit<TaskCreateState> {
  TaskCreateCubit() : super(TaskCreateState());

  Future<void> createTask(
      String description, String date, List<int> labelIds, bool isDone, String dateFinish) async {
    emit(state.copyWith(status: TaskCreateStatus.loading));
    try {
      final response =
          await TaskCreateService.createTask(description, date, labelIds, isDone, dateFinish);
      if (response.code == '0000') {
        emit(state.copyWith(status: TaskCreateStatus.success));
      } else {
        emit(state.copyWith(status: TaskCreateStatus.failure));
      }
    } catch (e) {
      emit(state.copyWith(status: TaskCreateStatus.failure));
    }
  }
}
