import 'package:registro_tareas_flutter_cubit/views/add_note_view.dart';
import 'package:flutter/material.dart';
import '../clases/Tag.dart';
import '../clases/TagList.dart';
import '../components/appbar_design1.dart';
import '../components/tag_item.dart';

class AddTagView extends StatefulWidget {
  @override
  _AddTagViewState createState() => _AddTagViewState();
}

class _AddTagViewState extends State<AddTagView> {
  List<Tag> optionsTags = listedTags.getVisbleTags();

  bool _showNewTagForm = false;
  final _newTagNameController = TextEditingController();

  void _onBack() {
    Navigator.pushNamed(context, '/AddNoteView');
  }

  void _showForm() {
    setState(() {
      _showNewTagForm = true;
    });
  }

  void _hideForm() {
    setState(() {
      _showNewTagForm = false;
    });
  }

  void _saveNewTag() {
    final newTagName = _newTagNameController.text.trim();
    if (newTagName.isNotEmpty) {
      final newTag = Tag(newTagName);
      optionsTags.add(newTag);
      setState(() {
        _newTagNameController.clear();
        _showNewTagForm = false;
      });
    }
  }

  void updateListView() {
    setState(() {});
  }

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
              child: ListView.builder(
                itemCount: optionsTags.length,
                itemBuilder: (context, index) {
                  return Container(
                      child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TagItem(optionsTags[index]),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          //listedTags.getTag(index).setDelete();
                          optionsTags.removeAt(index);

                          updateListView();
                        },
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                      ),
                    ],
                  ));
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
                      onPressed: _saveNewTag,
                      child: Text('Guardar'),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: _hideForm,
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
                  onPressed: _showForm,
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
                  listedTags.setNewTags(optionsTags);
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
