import 'package:flutter/material.dart';

class MultiSelectDropdownController {
  ValueNotifier<List<String>> _selectedItems = ValueNotifier<List<String>>([]);
  List<String> get selectedItems => _selectedItems.value;

  void updateSelectedItems(List<String> newSelectedItems) {
    _selectedItems.value = newSelectedItems;
  }
}
class MultiSelectDropdown extends StatefulWidget {
  final List<String> items;
  final String title;
  final Color? dropdownColor;
  final MultiSelectDropdownController? controller;

  MultiSelectDropdown({
    Key? key,
    required this.items,
    required this.title,
    this.dropdownColor,
    this.controller,
  }) : super(key: key);

  @override
  _MultiSelectDropdownState createState() => _MultiSelectDropdownState();
}

class _MultiSelectDropdownState extends State<MultiSelectDropdown> {
  List<String> _selectedItems = [];

  bool _isDropdownOpened = false;

  void _toggleDropdown() {
    setState(() {
      _isDropdownOpened = !_isDropdownOpened;
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      widget.controller!._selectedItems.addListener(() {
        setState(() {
          _selectedItems = widget.controller!.selectedItems;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _toggleDropdown,
          child: Container(
            height: 60, // Aumenta la altura del contenedor aquí.
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Theme.of(context).primaryColor),
            ),

            child: Row(
              children: [

                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      _selectedItems.isEmpty
                          ? 'Seleccione opciones'
                          : _selectedItems.join(', '),
                      style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).textTheme.bodyText1!.color),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        _isDropdownOpened
            ? Material(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: widget.dropdownColor ??
                        Theme.of(context).canvasColor,
                  ),
                  height: 200,
                  child: ListView.builder(
                    itemCount: widget.items.length,
                    itemBuilder: (context, index) {
                      return CheckboxListTile(
                        value: _selectedItems.contains(widget.items[index]),
                        onChanged: (bool? isChecked) {
                          setState(() {
                            if (isChecked == true) {
                              _selectedItems.add(widget.items[index]);
                            } else {
                              _selectedItems.remove(widget.items[index]);
                            }
                          });
                          if (widget.controller != null) {
                            widget.controller!
                                .updateSelectedItems(_selectedItems);
                          }
                        },
                        title: Text(widget.items[index]),
                      );
                    },
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}