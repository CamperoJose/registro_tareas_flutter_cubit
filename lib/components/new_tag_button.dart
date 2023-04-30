import 'package:flutter/material.dart';

class NewTagButton extends StatefulWidget {
  final Function(String) onSave;

  const NewTagButton({Key? key, required this.onSave}) : super(key: key);

  @override
  _NewTagButtonState createState() => _NewTagButtonState();
}

class _NewTagButtonState extends State<NewTagButton> {
  bool _showNewTagForm = false;
  final _newTagNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!_showNewTagForm)
          ElevatedButton(
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
        if (_showNewTagForm)
          Row(
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
                  widget.onSave(_newTagNameController.text);
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
      ],
    );
  }
}
