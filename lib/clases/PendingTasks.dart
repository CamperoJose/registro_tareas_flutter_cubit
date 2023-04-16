import 'package:registro_tareas_flutter_cubit/clases/Note.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class PendingTasks {
  List<Note> notes1 = [];
  PendingTasks(this.notes1);

  addNote(NoteA) {
    notes1.add(NoteA);
  }

  getSize() {
    return notes1.length;
  }

  getNote(int pos) {
    return notes1[pos];
  }

}

List<Note> notes1 = [];
PendingTasks PendingTasksList = PendingTasks(notes1);
