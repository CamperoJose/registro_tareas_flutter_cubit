import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bl/label_create_cubit.dart';
import '../bl/labels_cubit.dart';
import '../bl/labels_state.dart';
import '../bl/tags_cubit.dart';
import 'add_tag_view.dart';

Set<int> conjuntoDeEnteros = new Set<int>();

class LabelsDropdownButton extends StatefulWidget {
  const LabelsDropdownButton({Key? key}) : super(key: key);

  @override
  _LabelsDropdownButtonState createState() => _LabelsDropdownButtonState();
}

class _LabelsDropdownButtonState extends State<LabelsDropdownButton> {
  String? selectedLabel;

  @override
  void initState() {
    super.initState();
    context.read<LabelsCubit>().getLabels();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LabelsCubit, LabelsState>(
      listener: (context, state) {
        if (state.status == LabelsStatus.failure) {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('Error al obtener las etiquetas'),
              content: const Text(
                  'Ha ocurrido un error al obtener las etiquetas. ¿Desea intentarlo de nuevo?'),
              actions: <Widget>[
                TextButton(
                  child: const Text('Aceptar'),
                  onPressed: () {
                    BlocProvider.of<LabelsCubit>(context).getLabels();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        }
      },
      builder: (context, state) {
        print("reconstruyendo dropdown");
        if (state.status == LabelsStatus.loading) {
          return LinearProgressIndicator();
        } else if (state.status == LabelsStatus.success) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownButton<String>(
                value: selectedLabel,
                hint:
                    Text('Cantidad de etiquetas: ${conjuntoDeEnteros.length}'),
                underline: Container(
                  height: 0,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    if (conjuntoDeEnteros.contains(int.parse(newValue!))) {
                      conjuntoDeEnteros.remove(int.parse(newValue));
                    } else {
                      conjuntoDeEnteros.add(int.parse(newValue));
                    }
                  });
                },
                items: state.labels
                    .map<DropdownMenuItem<String>>(
                      (label) => DropdownMenuItem<String>(
                        value: label.labelId.toString(),
                        child: conjuntoDeEnteros.contains(label.labelId)
                            ? Text(
                                "Quitar: ${label.name}",
                                style: TextStyle(color: Colors.red),
                              )
                            : Text(
                                "Agregar: ${label.name}",
                                style: TextStyle(color: Colors.green),
                              ),
                      ),
                    )
                    .toList(),
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (context) => LabelCreateCubit(),
                        ),
                        BlocProvider<LabelsCubit>(
                          create: (context) => LabelsCubit()..getLabels(),
                        ),
                      ],
                      child: AddTagView(),
                    ))
                  );
                  
                  BlocProvider.of<LabelsCubit>(context).getLabels();
                },
              ),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
      listenWhen: (previous, current) {
        return false;
      },
    );
  }
}
