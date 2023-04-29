import 'package:flutter/material.dart';

class TextInput1 extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscureText;

  const TextInput1({
    Key? key,
    required this.controller,
    required this.hint,
    required this.obscureText,
  }) : super(key: key);

  @override
  _TextInput1State createState() => _TextInput1State();
}

class _TextInput1State extends State<TextInput1> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: widget.controller,
        obscureText: widget.obscureText && !_isVisible,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 81, 107, 255),
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 106, 73, 196),
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          fillColor: Color.fromARGB(255, 195, 202, 242),
          filled: true,
          hintText: widget.hint,
          hintStyle: TextStyle(color: Colors.grey[600]),
          suffixIcon: widget.obscureText
              ? IconButton(
                  icon: Icon(
                    _isVisible ? Icons.visibility : Icons.visibility_off,
                    color: Color.fromARGB(255, 81, 107, 255),
                  ),
                  onPressed: () {
                    setState(() {
                      _isVisible = !_isVisible;
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }
}
