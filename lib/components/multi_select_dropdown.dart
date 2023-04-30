import 'package:flutter/material.dart';

class MultiSelectDropdown extends StatefulWidget {
  final List<String> items;
  final String title;
  final Color? dropdownColor;

  MultiSelectDropdown({
    Key? key,
    required this.items,
    required this.title,
    this.dropdownColor,
  }) : super(key: key);

  @override
  _MultiSelectDropdownState createState() => _MultiSelectDropdownState();
}

class _MultiSelectDropdownState extends State<MultiSelectDropdown> {
  List<String> _selectedItems = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            icon: const Icon(Icons.arrow_drop_down_circle_outlined),
            isExpanded: true,
            dropdownColor: widget.dropdownColor,
            items: widget.items.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Row(
                  children: [
                    Checkbox(
                      value: _selectedItems.contains(value),
                      onChanged: (bool? isChecked) {
                        setState(() {
                          if (isChecked == true) {
                            _selectedItems.add(value);
                          } else {
                            _selectedItems.remove(value);
                          }
                        });
                      },
                    ),
                    Text(value),
                  ],
                ),
              );
            }).toList(),
            onChanged: (value) {},
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Seleccionados: ${_selectedItems.join(', ')}',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
