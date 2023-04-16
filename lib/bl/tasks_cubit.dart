import 'package:flutter_bloc/flutter_bloc.dart';

import '../clases/Note.dart';
import '../clases/PendingTasks.dart';

class PendingTasksCubit extends Cubit<PendingTasks> {
  PendingTasksCubit() : super(PendingTasks([]));

  void listedTasks() => emit(PendingTasksList);

  bool addNewNote(Note miNotaA) {
    try {
      PendingTasksList.addNote(miNotaA);
      emit(PendingTasksList);
      print("Tamaño de la lista ${PendingTasksList.getSize()}");
      return true;
    } catch (e) {
      return false;
    }
  }
}
