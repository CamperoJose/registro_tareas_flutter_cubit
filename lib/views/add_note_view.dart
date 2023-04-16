import 'package:registro_tareas_flutter_cubit/clases/Tag.dart';
import 'package:registro_tareas_flutter_cubit/views/add_tag_view.dart';
import 'package:registro_tareas_flutter_cubit/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:registro_tareas_flutter_cubit/clases/Note.dart';
//import 'package:registro_tareas_flutter_cubit/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:registro_tareas_flutter_cubit/views/home1_view.dart';
import '../clases/PendingTasks.dart';
import '../clases/TagList.dart';
import '../components/appbar_design1.dart';

class AddNoteView extends StatefulWidget {
  @override
  _AddNoteViewState createState() => _AddNoteViewState();
}

class _AddNoteViewState extends State<AddNoteView> {
  List<Tag> optionsTags = listedTags.getVisbleTags();

  final _noteName = TextEditingController();
  late Tag _noteTag;
  TextEditingController _noteDate = TextEditingController();
  late DateTime valueDate;

  @override
  Widget build(BuildContext context) {
    const double kVerticalPadding = 20.0;
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
                    SizedBox(height: kVerticalPadding),

                    //cambios input fecha:

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

                            setState(() {
                              _noteDate.text = DateFormat('yyyy-MM-dd HH:mm')
                                  .format(pickedDateTime);
                              valueDate = pickedDateTime;
                            });
                          }
                        }
                      },
                    ),

                    SizedBox(height: kVerticalPadding),

                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField(
                            onTap: () {
                              setState(() {
                                optionsTags = listedTags.getVisbleTags();
                              });
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
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddTagView()),
                            );
                            //if (result != null && result == 'added') {
                              setState(() {
                                optionsTags = listedTags.getVisbleTags();
                              });
                            //}
                          },
                          child: Icon(Icons.edit),
                        ),
                      ],
                    ),

                    //COMBO BOX INCIO:

                    //COMBO BOX FIN:

                    SizedBox(height: kVerticalPadding),
                    ElevatedButton(
                      onPressed: () {
                        Note miNotaA =
                            Note(_noteName.text, valueDate, _noteTag);
                        PendingTasksList.addNote(miNotaA);

                        Navigator.pushNamed(context, '/home1');

                        Fluttertoast.showToast(
                          msg: 'Tarea guardada',
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
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

                    SizedBox(height: kVerticalPadding),
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
