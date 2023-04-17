import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:registro_tareas_flutter_cubit/components/text_field_design1.dart';
import 'package:registro_tareas_flutter_cubit/components/button_design1.dart';
import 'package:registro_tareas_flutter_cubit/clases/Note.dart';
import 'package:registro_tareas_flutter_cubit/clases/PendingTasks.dart';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:registro_tareas_flutter_cubit/views/add_note_view.dart';

import '../bl/tasks_cubit.dart';
import '../clases/PendingTasks.dart';
import '../clases/Tag.dart';
import '../clases/TagList.dart';
import '../components/todo_item.dart';


class HomeView extends StatelessWidget {
  final cubitTasks = PendingTasksCubit();

  @override
  Widget build(BuildContext context) {
    void _onLogout() {
      Navigator.pushNamed(context, '/');
    }

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
            BlocBuilder<PendingTasksCubit, PendingTasks>(
              builder: (PendingTasksCubit, cubitTasks) {
                print("Reconstruyendo");
                return Expanded(
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
                );
              }, 
            ),
            ElevatedButton(onPressed: (){
              BlocProvider.of<PendingTasksCubit>(context).listedTasks();
            }, child: Text("Actualizar"))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo[700],
        hoverColor: Colors.indigo[500],
        onPressed: () async {
            final result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => BlocProvider(
              create: (context) => cubitTasks,
              child: AddNoteView(cubitTasks),
            ),));
            print(result);
            BlocProvider.of<PendingTasksCubit>(context).listedTasks();
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
