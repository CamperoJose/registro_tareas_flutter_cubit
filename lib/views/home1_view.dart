import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keychain/flutter_keychain.dart';
import '../bl/tasks_cubit.dart';
import '../bl/tasks_state.dart';
import '../components/appbar_design1.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TasksCubit>(context).getTasks();

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
                      content: const Text('Ha ocurrido un error al obtener las tareas. ¿Desea intentarlo de nuevo?'),
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
                return previous.status != current.status;
              },
              listenWhen: (previous, current) {
                return previous.status != current.status;
              },
              builder: (context, state) {
            if (state.status == TasksStatus.loading) {
              return const Expanded(child: Center(child: CircularProgressIndicator()));
            } else if (state.status == TasksStatus.success) {
              if (state.tasks.isNotEmpty) {
                return Expanded(
                  child: ListView.separated(
                    itemCount: state.tasks.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 16.0),
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
      return const Expanded(child: Center(child: Text('No hay tareas pendientes')));
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
        backgroundColor: Colors.indigo[700],
        hoverColor: Colors.indigo[500],
        onPressed: () async {
          var value = await FlutterKeychain.get(key: "AuthToken");
          BlocProvider.of<TasksCubit>(context).getTasks();
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
