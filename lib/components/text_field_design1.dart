import 'package:flutter/material.dart';

class TextInput1 extends StatelessWidget {
  final controller;
  final String hint;
  final bool obscureText;

  const TextInput1({super.key, required this.controller, required this.hint, required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
  
      child: TextField(
        controller: controller,
        obscureText: obscureText,
      
        decoration: InputDecoration(
          
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Color.fromARGB(255, 81, 107, 255),
          )),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Color.fromARGB(255, 106, 73, 196),
          )),
          fillColor: Color.fromARGB(255, 195, 202, 242),
          filled: true,
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[600])
          
        ),
        
      ),
      

    );
  }
}
