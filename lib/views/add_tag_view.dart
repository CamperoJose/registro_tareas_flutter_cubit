import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bl/label_create_state.dart';
import '../bl/label_create_cubit.dart';
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
            Expanded(
              child: BlocConsumer<LabelsCubit, LabelsState>(
                listener: (context, state) {},
                buildWhen: (previous, current) {
                  return true;
                },
                listenWhen: (previous, current) {
                  return true;
                },
                builder: (context, state) {
                  print(
                      "reconstruyendo listado de etiquetas con estado: $state");
                  if (state.status == LabelsStatus.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state.status == LabelsStatus.success) {
                    return ListView.builder(
                      itemCount: state.labels.length,
                      itemBuilder: (context, index) {
                        final label = state.labels[index];
                        return Container(
                        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.red.shade200,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          title: Text(
                            label.name,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.indigo[100],
                                ),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.purple,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    print("presionado boton editar de ${label.name}");
                                  },
                                ),
                              ),
                              SizedBox(width: 8),
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.indigo[100],
                                ),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    print("presionado boton borrar de ${label.name}");
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );

                      },
                    );
                  } else {
                    BlocProvider.of<LabelsCubit>(context).getLabels();
                    return const Center(
                      child: Text('Failed to load labels'),
                    );
                  }
                },
              ),
            ),
            Container(
              height: 120.0,
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  NewTagButton(
                    newTagNameController: _newTagNameController,
                    onSave: (newTagName) async {
                      // Aquí puedes usar el LabelCreateCubit para crear una nueva etiqueta
                      await BlocProvider.of<LabelCreateCubit>(context)
                          .createLabel(newTagName, DateTime.now().toString());
                      BlocProvider.of<LabelsCubit>(context).getLabels();
                    },
                  ),
                  const SizedBox(height: 10.0),
                  BlocConsumer<LabelCreateCubit, LabelCreateState>(
                    listenWhen: (previous, current) => true,
                    listener: (context, state) {
                      if (state.status == LabelCreateStatus.success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Etiqueta creada correctamente"),
                          ),
                        );
                        _newTagNameController.clear();
                        BlocProvider.of<LabelsCubit>(context).getLabels();
                      } else if (state.status == LabelCreateStatus.failure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Error al crear la etiqueta"),
                          ),
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
          ],
        ),
      ),
    );
  }
}
