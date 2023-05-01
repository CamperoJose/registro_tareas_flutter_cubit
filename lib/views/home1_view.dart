import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keychain/flutter_keychain.dart';
import 'package:intl/intl.dart';
import 'package:registro_tareas_flutter_cubit/dto/labels_response.dart';
import '../bl/task_create_cubit.dart';
import '../bl/tasks_cubit.dart';
import '../bl/tasks_state.dart';
import '../components/appbar_design1.dart';
import '../services/labels_service.dart';
import 'add_task_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  // Lógica para conseguir listado de etiquetas y sus nombres:
  Future<List<String>> getLabelsNames() async {
    try {
      final response = await LabelService.getLabels();
      final labels = response.labels;
      final labelsNames = labels.map((e) => e.name).toList();
      return labelsNames;
    } catch (e) {
      print(e);
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[100],
        shadowColor: Colors.transparent,
        title: Text(
          "Tareas Pendientes",
          style: TextStyle(
            color: Colors.indigo[700],
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.logout, color: Colors.indigo),
          onPressed: () async {
            await FlutterKeychain.remove(
                key: 'token'); // elimina el token guardado
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.indigo[100],
      body: SafeArea(
        child: Column(
          children: [
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
                return FutureBuilder<List<String>>(
                  future: getLabelsNames(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final labelsNames = snapshot.data!;
                      if (state.status == TasksStatus.loading) {
                        return const Expanded(
                            child: Center(child: CircularProgressIndicator()));
                      } else if (state.status == TasksStatus.success) {
                        if (state.tasks.isNotEmpty) {
                          return Expanded(
                            child: ListView.separated(
                              itemCount: state.tasks.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 16.0),
                              itemBuilder: (context, index) {
                                final task = state.tasks[index];
                                return Container(
                                  padding: const EdgeInsets.only(
                                    left: 16.0,
                                    right: 16.0,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFEAF5FC),
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    padding: const EdgeInsets.only(
                                      left: 16.0,
                                      top: 16.0,
                                      right: 16.0,
                                      bottom: 16.0,
                                    ),
                                    child: CheckboxListTile(
                                      value: task.isDone,
                                      onChanged: (value) async {
                                        // Guardar fecha actual en variable:
                                        final dateFinish =
                                            DateTime.now().toString();

                                        DateTime dateTime =
                                            DateTime.parse(dateFinish);

                                        // Crear una nueva fecha y hora en formato "2099-02-01T00:00:00Z"

                                        String fecha2 =
                                            dateTime.toIso8601String();

                                        await BlocProvider.of<TasksCubit>(
                                                context)
                                            .updateTask(
                                          task.taskId,
                                          task.description,
                                          task.date,
                                          task.labelIds,
                                          !task.isDone,
                                          fecha2,
                                        );
                                      },
                                      title: Text(
                                        task.description,
                                        style: TextStyle(
                                          color: task.isDone
                                              ? Colors.red
                                              : const Color(0xFF5E35B1),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0,
                                          decoration: task.isDone
                                              ? TextDecoration.lineThrough
                                              : null,
                                        ),
                                      ),
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      activeColor: Colors.red,
                                      checkColor: Colors.white,
                                      secondary: IconButton(
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.purple,
                                        ),
                                        onPressed: () async {
                                          print(
                                              "editar tarea ${task.description}");
                                          final updateTask = await showDialog(
                                            context: context,
                                            builder: (context) {
                                              final descriptionController =
                                                  TextEditingController(
                                                text: task.description,
                                              );
                                              return AlertDialog(
                                                title:
                                                    const Text('Editar tarea'),
                                                content: TextFormField(
                                                  controller:
                                                      descriptionController,
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: 'Descripción',
                                                  ),
                                                ),
                                                actions: [
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.of(context).pop(
                                                          descriptionController
                                                              .text);
                                                    },
                                                    child:
                                                        const Text("Aceptar"),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                          if (updateTask != null) {
                                            await BlocProvider.of<TasksCubit>(
                                                    context)
                                                .updateTask(
                                              task.taskId,
                                              updateTask,
                                              task.date,
                                              task.labelIds,
                                              task.isDone,
                                              task.dateFinish,
                                            );
                                            print(task.date);
                                          }
                                        },
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Etiquetas: ${task.labelIds.map((labelId) => labelsNames[labelId - 1]).join(', ')}',
                                            style: TextStyle(
                                              color: const Color(0xFF3949AB),
                                              fontSize: 14.0,
                                            ),
                                          ),
                                          Text(
                                            'Fecha límite: ${DateFormat('dd/MM/yyyy HH:mm').format(DateTime.parse(task.date))}',
                                            style: TextStyle(
                                              color: const Color(0xFF7E57C2),
                                              fontSize: 14.0,
                                            ),
                                          ),
                                          task.isDone == true
                                              ? Text(
                                                  'Fecha terminado: ${DateFormat('dd/MM/yyyy HH:mm').format(DateTime.parse(task.dateFinish))}',
                                                  style: TextStyle(
                                                    color:
                                                        const Color(0xFF7E57C2),
                                                    fontSize: 14.0,
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        } else {
                          return const Expanded(
                              child: Center(
                                  child: Text('No hay tareas pendientes')));
                        }
                      } else {
                        BlocProvider.of<TasksCubit>(context).getTasks();
                        return FloatingActionButton(
            onPressed: () {
              BlocProvider.of<TasksCubit>(context).getTasks();
            },
            child: Icon(Icons.refresh));
          
                      }
                    } else {
                      return const Expanded(
                          child: Center(child: CircularProgressIndicator()));
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => TaskCreateCubit(),
              child: AddNoteView(),
            ),
          ));
          BlocProvider.of<TasksCubit>(context).getTasks();
        },
        tooltip: 'Agregar nueva tarea',
        child: const Icon(Icons.add_rounded, size: 50),
      ),
    );
  }
}
