import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keychain/flutter_keychain.dart';
import 'package:registro_tareas_flutter_cubit/clases/PendingTasks.dart';
import 'package:registro_tareas_flutter_cubit/views/add_note_view.dart';
import '../bl/tasks_cubit.dart';
import '../components/appbar_design1.dart';
import '../components/todo_item.dart';

class HomeView extends StatelessWidget {
  final cubitTasks = PendingTasksCubit();

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.indigo[100],
      body: SafeArea(
        child: Column(
          children: [
            const MyAppBar(title: "Tareas pendientes"),


            BlocBuilder<PendingTasksCubit, PendingTasks>(
              builder: (PendingTasksCubit, cubitTasks) {
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
          ],
        ),
      ),



      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo[700],
        hoverColor: Colors.indigo[500],
        onPressed: () async {
          var value = await FlutterKeychain.get(key: "AuthToken");

          final result = await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => cubitTasks,
              child: AddNoteView(cubitTasks),
            ),
          ));
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
