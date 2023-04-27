import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:registro_tareas_flutter_cubit/clases/Tag.dart';
import 'package:registro_tareas_flutter_cubit/views/add_tag_view.dart';
import 'package:flutter/material.dart';
import 'package:registro_tareas_flutter_cubit/clases/Note.dart';
import 'package:intl/intl.dart';
import 'package:registro_tareas_flutter_cubit/views/home1_view.dart';
import '../bl/tags_cubit.dart';
import '../bl/tasks_cubit.dart';
import '../clases/PendingTasks.dart';
import '../clases/TagList.dart';
import '../components/appbar_design1.dart';

class AddNoteView extends StatelessWidget {
  final PendingTasksCubit cubitTasks;

  AddNoteView(this.cubitTasks);

  Widget build(BuildContext context) {
    final TagsCubit cubitTags = TagsCubit();
    ListedTags listedTags = cubitTags.state;
    List<Tag> optionsTags = listedTags.getVisbleTags();

    final _noteName = TextEditingController();
    late Tag _noteTag;
    TextEditingController _noteDate = TextEditingController();
    late DateTime valueDate;
    return Scaffold(
      backgroundColor: Colors.indigo[100],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MyAppBar(title: "Registrar Nueva tarea"),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _noteName,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.note_add_rounded),
                        labelText: 'Nombre de la tarea',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    TextField(
                      controller: _noteDate,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.calendar_today_outlined),
                        labelText: 'Fecha límite de la tarea',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                        );

                        if (pickedDate != null) {
                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );

                          if (pickedTime != null) {
                            DateTime pickedDateTime = DateTime(
                              pickedDate.year,
                              pickedDate.month,
                              pickedDate.day,
                              pickedTime.hour,
                              pickedTime.minute,
                            );

                            _noteDate.text = DateFormat('yyyy-MM-dd HH:mm')
                                .format(pickedDateTime);
                            valueDate = pickedDateTime;
                          }
                        }
                      },
                    ),

                    SizedBox(height: 20),

                    Row(
                      children: [
                        BlocProvider(
                          create: (context) => cubitTags,
                          child: BlocConsumer<TagsCubit, ListedTags>(
                            builder: (context, state) {
                              optionsTags = state.getVisbleTags();
                              return Expanded(
                                child: DropdownButtonFormField(
                                  onTap: () {
                                    optionsTags = state.getVisbleTags();
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.tag_rounded),
                                    labelText: 'Etiqueta',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  items: optionsTags.map((name) {
                                    return DropdownMenuItem(
                                      child: Text(name.tagName),
                                      value: name,
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    _noteTag = value!;
                                  },
                                ),
                              );
                            },
                            listener: (context, state) {
                              print("llega al listener 1");
                              cubitTags.listedTag();
                            },
                            buildWhen: (previous, current) {
                              print("old: $previous");
                              print("new: $current");
                              return true;
                            },
                            listenWhen: (previous, current) {
                              print("old: $previous");
                              print("new: $current");
                              return true;
                            },
                          ),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () async {
                            final result = await Navigator.of(context)
                                .push(MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) => cubitTags,
                                child: AddTagView(cubitTags),
                              ),
                            ));
                            cubitTags.emit(result);
                            optionsTags = cubitTags.state.getVisbleTags();
                          },
                          child: Icon(Icons.edit),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Note miNotaA =
                            Note(_noteName.text, valueDate, _noteTag);
                        cubitTasks.addNewNote(miNotaA);
                        Navigator.pop(context, true);
                      },
                      child: Text('Guardar'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                        primary: Colors.indigo,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),

                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancelar'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                        primary: Colors.red.shade900,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}