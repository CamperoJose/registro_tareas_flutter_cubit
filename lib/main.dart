import 'package:registro_tareas_flutter_cubit/views/add_tag_view.dart';
import 'package:flutter/material.dart';
import 'views/login_view.dart';
import 'views/home1_view.dart';
import 'views/add_note_view.dart';
import 'package:registro_tareas_flutter_cubit/clases/Note.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.indigo, width: 2.0),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => LoginView(),
        '/home1': (context) => HomeView(),
      },
    );
  }
}
