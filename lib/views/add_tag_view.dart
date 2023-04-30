import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:registro_tareas_flutter_cubit/views/add_task_view.dart';
import 'package:flutter/material.dart';
import '../bl/tags_cubit.dart';
import '../clases/Tag.dart';
import '../clases/TagList.dart';
import '../components/appbar_design1.dart';
import '../components/tag_item.dart';

class AddTagView extends StatefulWidget {
  final TagsCubit cubitTags;

  AddTagView(this.cubitTags);

  @override
  _AddTagViewState createState() => _AddTagViewState();
}

class _AddTagViewState extends State<AddTagView> {
  bool _showNewTagForm = false;
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
            BlocProvider(
              create: (context) => widget.cubitTags,
              child: BlocBuilder<TagsCubit, ListedTags>(
                builder: (context, state) {
                  print("reconstruye el widget2");
return Expanded(
child: ListView.builder(
itemCount: state.getSize(),
itemBuilder: (context, index) {
return Container(
child: Row(
children: [
Expanded(
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
TagItem(state.tags[index]),
],
),
),
IconButton(
onPressed: () {
widget.cubitTags.removeAt(index);
widget.cubitTags.listedTag();
},
icon: Icon(Icons.delete),
color: Colors.red,
),
],
));
},
),
);
},
),
),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ElevatedButton(
            onPressed: () {
              widget.cubitTags.addTag(Tag('Nueva Etiqueta'));
            },
            child: Text('Agregar Etiqueta'),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 50),
              primary: Colors.indigo,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        if (!_showNewTagForm)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _showNewTagForm = true;
                });
              },
              child: Text('Nueva Etiqueta'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                primary: Colors.indigo,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        SizedBox(height: 10),
        if (_showNewTagForm)
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _newTagNameController,
                    decoration: InputDecoration(
                      hintText: 'Nueva Etiqueta',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    widget.cubitTags.addTag(Tag(_newTagNameController.text));
                    widget.cubitTags.listedTag();
                    _newTagNameController.clear();
                    setState(() {
                      _showNewTagForm = false;
                    });
                  },
                  child: Text('Guardar'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _showNewTagForm = false;
                    });
                  },
                  child: Text('Cerrar'),
                ),
              ],
            ),
          ),

        SizedBox(height: 10),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context, widget.cubitTags.state);
            },
            child: Text('Guardar'),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 50),
              primary: Colors.green[700],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ElevatedButton(
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
        ),
      ],
    ),
  ),
);
}
}