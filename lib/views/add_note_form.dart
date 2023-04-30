import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bl/task_create_cubit.dart';
import '../components/custom_date_time_picker.dart';
import '../components/custom_elevated_button.dart';
import '../services/multi_select_dropdown.dart';
import '../components/text_field_design2.dart';

class AddNoteForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // Controladores para los campos de texto y fecha
    final noteName = TextEditingController();
    TextEditingController _noteDate = TextEditingController();
    return Column(
      children: [
        CustomTextField(
          controller: noteName,
          labelText: 'Nombre de la tarea',
          prefixIcon: Icons.note_add_rounded,
        ),
        const SizedBox(height: 20), // Espaciado entre los widgets
        CustomDateTimePicker(
          controller: _noteDate,
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: MultiSelectDropdown(
                items: const ["1", "2", "3", "4", "5"],
                title: "Selecciona labels",
                dropdownColor: Colors.blue.shade100,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.purpleAccent),
              onPressed: () {

              },
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CustomElevatedButton(
                buttonText: 'Guardar',
                onPressed: () async {
                  // Convertir la fecha seleccionada a formato ISO8601 y guardar la tarea
                  DateTime date1 = DateTime.parse("${_noteDate.text.replaceAll(" ", "T")}Z");
                  String fecha2 = date1.toIso8601String();
                  await BlocProvider.of<TaskCreateCubit>(context).createTask(
                      noteName.text, fecha2, [1, 2, 3, 4]);
                },
                primaryColor: Colors.green.shade900,
              ),
            ),
            const SizedBox(width: 20), // Espaciado entre los botones
            Expanded(
              child: CustomElevatedButton(
                buttonText: 'Cancelar',
                onPressed: () {
                  Navigator.pop(context);
                },
                primaryColor: Colors.red.shade900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20), // Espaciado final
      ],
    );
  }
}
