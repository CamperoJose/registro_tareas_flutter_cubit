import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:registro_tareas_flutter_cubit/views/add_note_view.dart';
import 'package:flutter/material.dart';
import '../bl/tags_cubit.dart';
import '../clases/Tag.dart';
import '../clases/TagList.dart';
import '../components/appbar_design1.dart';
import '../components/tag_item.dart';

class AddTagView extends StatelessWidget {
  final TagsCubit cubitTags;

  AddTagView(this.cubitTags);

  final TagsCubit cubitTagsList = TagsCubit();
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
              create: (context) => cubitTagsList,
              child: BlocConsumer<TagsCubit, ListedTags>(
                builder: (context, state) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: listedTags.getSize(),
                      itemBuilder: (context, index) {
                        return Container(
                            child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TagItem(listedTags.tags[index]),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                //listedTags.getTag(index).setDelete();

                                
                                listedTags.removeAt(index);

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
                listener: (context, state) {
                  print("llega al listener");
                  BlocProvider.of<TagsCubit>(context).listedTag();
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
                      onPressed: (){},
                      child: Text('Guardar'),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: (){},
                      child: Text('Cerrar'),
                    ),
                  ],
                ),
              ),
            SizedBox(height: 10),
            if (!_showNewTagForm)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ElevatedButton(
                  onPressed: (){},
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  
                  cubitTags.listedTag();
                  //listedTags = optionsTags;
                  Navigator.pop(context);
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
