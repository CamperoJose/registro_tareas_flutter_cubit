import 'package:flutter/material.dart';
import 'package:registro_tareas_flutter_cubit/components/text_field_design1.dart';
import 'package:registro_tareas_flutter_cubit/components/button_design1.dart';
import 'package:registro_tareas_flutter_cubit/clases/Note.dart';
import 'package:registro_tareas_flutter_cubit/clases/PendingTasks.dart';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:registro_tareas_flutter_cubit/views/add_note_view.dart';

import '../clases/PendingTasks.dart';
import '../clases/Tag.dart';
import '../clases/TagList.dart';
import '../components/todo_item.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeView createState() => _HomeView();
}

class _HomeView extends State<HomeView> {

  void _onLogout() {
     Navigator.pushNamed(context, '/');
   }


@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.indigo[100],
    body: SafeArea(
      child: Column(
        children: [
          AppBar(
            backgroundColor: Colors.indigo[100],
            shadowColor: Colors.transparent,
            title: Text(
              'FacileTask',
              style: TextStyle(
                color: Colors.indigo[700],
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: IconButton(
              icon: Icon(Icons.logout_rounded),
              color: Colors.pink,
              onPressed: _onLogout,
              iconSize: 30,
            ),
          ),
          Expanded(
            child: PendingTasksList.getSize() > 0
                ? ListView.builder(
                    itemCount: PendingTasksList.getSize(),
                    itemBuilder: (context, index) {
                      return ToDoItem(PendingTasksList.getNote(index));
                    },
                  )
                : Center(
                    child: Text(
                      'No hay tareas pendientes',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
          ),
        ],
      ),
    ),
    floatingActionButton: FloatingActionButton(
      backgroundColor: Colors.indigo[700],
      hoverColor: Colors.indigo[500],
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddNoteView(),
        ));
      },
      tooltip: 'Agregar nueva tarea',
      child: const Icon(
        Icons.add_rounded,
        size: 50,
      ),
    ),
  );
}
}
