import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  final String title;

  const MyAppBar({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.indigo[100],
      shadowColor: Colors.transparent,
      title: Text(
        title,
        style: TextStyle(
          color: Colors.indigo[700],
          fontWeight: FontWeight.bold,
        ),
      ),
      iconTheme: IconThemeData(color: Colors.red),
      
    );
  }
}
