// En home_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keychain/flutter_keychain.dart';
import '../bl/task_create_cubit.dart';
import '../bl/tasks_cubit.dart';
import '../bl/tasks_state.dart';
import '../components/appbar_design1.dart';
import 'add_task_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    BlocProvider.of<TasksCubit>(context).getTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[100],
      body: SafeArea(
        child: Column(
          children: [
            const MyAppBar(title: "Tareas pendientes"),
            BlocConsumer<TasksCubit, TasksState>(
              listener: (context, state) {
                if (state.status == TasksStatus.failure) {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Error al obtener las tareas'),
                      content: const Text(
                          'Ha ocurrido un error al obtener las tareas. ¿Desea intentarlo de nuevo?'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Aceptar'),
                          onPressed: () {
                            BlocProvider.of<TasksCubit>(context).getTasks();
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  );
                }
              },
              buildWhen: (previous, current) {
                return true;
              },
              listenWhen: (previous, current) {
                return true;
              },
              builder: (context, state) {
                if (state.status == TasksStatus.loading) {
                  return const Expanded(
                      child: Center(child: LinearProgressIndicator()));
                } else if (state.status == TasksStatus.success) {
                  if (state.tasks.isNotEmpty) {
                    return Expanded(
                      child: ListView.separated(
                        itemCount: state.tasks.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 16.0),
                        itemBuilder: (context, index) {
                          final task = state.tasks[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('ID: ${task.taskId}'),
                              Text('Fecha: ${task.date}'),
                              Text('Label IDs: ${task.labelIds.toString()}'),
                              Text(task.description),
                            ],
                          );
                        },
                      ),
                    );
                  } else {
                    return const Expanded(
                        child: Center(child: Text('No hay tareas pendientes')));
                  }
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
            BlocProvider(
                create: (context) => TaskCreateCubit(),
                child: AddNoteView(),
            ),
          
          ));


          // ignore: use_build_context_synchronously
          BlocProvider.of<TasksCubit>(context).getTasks();

          ;
        },
        tooltip: 'Agregar nueva tarea',
        child: const Icon(Icons.add_rounded, size: 50),
      ),
    );
  }
}
