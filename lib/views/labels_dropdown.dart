import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bl/labels_cubit.dart';
import '../bl/labels_state.dart';

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
        if (state.status == LabelsStatus.loading) {
          return LinearProgressIndicator();
            
        } else if (state.status == LabelsStatus.success) {
          return DropdownButton<String>(
            value: selectedLabel,
            hint: const Text('Seleccionar etiqueta'),
            onChanged: (String? newValue) {
              setState(() {
                selectedLabel = newValue;
              });
            },
            items: state.labels
                .map<DropdownMenuItem<String>>(
                  (label) => DropdownMenuItem<String>(
                    value: label.name,
                    child: Text(label.name),
                  ),
                )
                .toList(),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
