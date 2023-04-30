import 'package:registro_tareas_flutter_cubit/clases/Tag.dart';
import 'package:flutter/material.dart';
import '../components/appbar_design1.dart';
import '../components/custom_date_time_picker.dart';
import '../components/custom_elevated_button.dart';
import '../components/multi_select_dropdown.dart';
import '../components/text_field_design2.dart';

class AddNoteView extends StatelessWidget {
  const AddNoteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final noteName = TextEditingController();
    late Tag noteTag;
    TextEditingController _noteDate = TextEditingController();
    late DateTime valueDate;

    return Scaffold(
      backgroundColor: Colors.indigo[100],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const MyAppBar(title: "Registrar Nueva tarea"),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  children: [
                    CustomTextField(
                      controller: noteName,
                      labelText: 'Nombre de la tarea',
                      prefixIcon: Icons.note_add_rounded,
                    ),
                    const SizedBox(height: 20),
                    CustomDateTimePicker(
                      controller: _noteDate,
                    ),
                    const SizedBox(height: 20),
                    MultiSelectDropdown(
                      items: ["1", "2", "3", "4", "5"],
                      title: "Selecciona elementos",
                      dropdownColor: Colors.blue.shade100,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CustomElevatedButton(
                            buttonText: 'Guardar',
                            onPressed: () {
                              var list = ["1", "2"];
                              print("texto: ${noteName.text}");
                              print("fecha: ${_noteDate.text}");
                              print("tags: $list");


                              
                            },
                            primaryColor: Colors.green.shade900,
                          ),
                        ),
                        SizedBox(width: 20), // Espaciado entre los botones
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
                    const SizedBox(height: 20),
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
