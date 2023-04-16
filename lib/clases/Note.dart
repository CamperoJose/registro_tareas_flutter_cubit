import 'package:registro_tareas_flutter_cubit/clases/Tag.dart';

class Note {
  String noteName;
  DateTime dueDate;
  String status;
  Tag tag;
  late DateTime finishDate;

  Note(this.noteName, this.dueDate, this.tag, {this.status = "Pendiente",});

  isDone() {
    finishDate = DateTime.now();
    status = "Realizado";
  }

  isNotDone() {
    status = "Pendiente";
  }

  getName() {
    return noteName;
  }

  getDate() {
    return dueDate;
  }

  getStatus() {
    return status;
  }

  getTag() {
    return tag.getTagname();
  }
}
