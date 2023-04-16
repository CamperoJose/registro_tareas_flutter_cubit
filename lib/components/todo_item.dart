import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../clases/Note.dart';

class ToDoItem extends StatefulWidget {
  Note NoteA;

  ToDoItem(this.NoteA);

  @override
  _ToDoItemState createState() => _ToDoItemState();
}

class _ToDoItemState extends State<ToDoItem> {
  @override
  Widget build(BuildContext context) {
    bool _isDone = false;
    if (widget.NoteA.status == "Realizado") {
      _isDone = true;
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Theme(
            data: ThemeData(
              checkboxTheme: CheckboxThemeData(
                fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                  if (states.contains(MaterialState.selected)) {
                    return Colors.purple; // color de fondo cuando está marcado
                  }
                  return Colors
                      .black; // color de fondo cuando no está marcado
                }),
                overlayColor: MaterialStateProperty.all(
                    Colors.transparent), // color del efecto al tocar
                splashRadius: 20, // tamaño del efecto al tocar
                materialTapTargetSize:
                    MaterialTapTargetSize.padded, // tamaño del target al tocar
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color:
                          Colors.red), // color del borde cuando no está marcado
                  borderRadius:
                      BorderRadius.circular(6), // radio de borde del checkbox
                ),
              ),
            ),
            child: Checkbox(
              value: _isDone,
              onChanged: (newValue) {
                if (_isDone == false) {
                  widget.NoteA.isDone();
                } else {
                  widget.NoteA.isNotDone();
                }
                setState(() {
                  _isDone = newValue!;
                });
              },
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.NoteA.noteName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: _isDone ? Colors.black : Colors.purple,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  _isDone
                      ? "Concluido el: ${DateFormat('d MMM y hh:mm').format(widget.NoteA.finishDate)}"
                      : "Fecha límite: ${DateFormat('d MMM y hh:mm').format(widget.NoteA.dueDate)}",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.NoteA.status,
                  style: TextStyle(
                    fontSize: 12,
                    color: _isDone
                        ? Colors.green
                        : (widget.NoteA.status == 'Realizado'
                            ? Colors.green
                            : Colors.red),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "#${widget.NoteA.getTag()}",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
