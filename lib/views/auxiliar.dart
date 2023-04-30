import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bl/label_create_state.dart';
import '../bl/label_create_cubit.dart'; // Importamos el LabelCreateCubit
import '../bl/labels_cubit.dart';
import '../bl/labels_state.dart';
import '../components/appbar_design1.dart';
import '../components/custom_elevated_button.dart';
import '../components/new_tag_button.dart';

class AddTagView extends StatelessWidget {
  final _newTagNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const double kVerticalPadding = 20.0;
    return Scaffold(
      backgroundColor: Colors.indigo[100],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MyAppBar(title: "Editar Etiquetas"),
            BlocProvider<LabelsCubit>(
              create: (_) => LabelsCubit()..getLabels(),
              child: BlocConsumer<LabelsCubit, LabelsState>(
                listener: (context, state) {
                  print("llega a listener de etiquetas");
                  //logica para recontruir cuando NewTagButton crea una nueva etiqueta usando context:
                
                },
                buildWhen: (previous, current) {
                  return true;
                },
                listenWhen: (previous, current) {
                  return true;
                },
                builder: (context, state) {
                  print("reconstruyendo listado de etiquetas");
                  if (state.status == LabelsStatus.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state.status == LabelsStatus.success) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: state.labels.length,
                        itemBuilder: (context, index) {
                          final label = state.labels[index];
                          return ListTile(
                            title: Text(label.name),
                          );
                        },
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text('Failed to load labels'),
                    );
                  }
                },
              ),
            ),


            BlocProvider<LabelCreateCubit>(
              create: (_) => LabelCreateCubit(),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 25.0, vertical: kVerticalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    NewTagButton(
                      newTagNameController: _newTagNameController,
                      onSave: (newTagName) async {
                        // Aquí puedes usar el LabelCreateCubit para crear una nueva etiqueta
                        await BlocProvider.of<LabelCreateCubit>(context)
                            .createLabel(newTagName, DateTime.now().toString());
                      },
                    ),
                    SizedBox(height: 10),
                    BlocConsumer<LabelCreateCubit, LabelCreateState>(
                      listenWhen: (previous, current) =>
                          current.status != LabelCreateStatus.init,
                      listener: (context, state) {
                        if (state.status == LabelCreateStatus.success) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text("Etiqueta creada correctamente")),
                          );
                          _newTagNameController.clear();
                          BlocProvider.of<LabelsCubit>(context).getLabels();
                        } else if (state.status == LabelCreateStatus.failure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text("Error al crear la etiqueta")),
                          );
                        }
                      },
                      buildWhen: (previous, current) {
                        return true;
                      },
                      builder: (context, state) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: CustomElevatedButton(
                                buttonText: 'Guardar',
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                primaryColor: Colors.green.shade900,
                              ),
                            ),
                            const SizedBox(width: 20),
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
                        );
                      },
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
