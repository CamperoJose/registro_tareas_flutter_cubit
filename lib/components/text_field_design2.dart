import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData prefixIcon;

  CustomTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon, color: Theme.of(context).primaryColor),
        labelText: labelText,
        labelStyle: TextStyle(color: Theme.of(context).primaryColor),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Theme.of(context).accentColor),
        ),
      ),
      style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color),
    );
  }
}
