import 'package:flutter/material.dart';
import 'package:registro_tareas_flutter_cubit/components/text_field_design1.dart';
import 'package:registro_tareas_flutter_cubit/components/button_design1.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();

  void _signUserIn() {
  // Validar que los campos de entrada no estén vacíos
  if (_userController.text.isEmpty || _passwordController.text.isEmpty) {
    Fluttertoast.showToast(
      msg: 'Ingrese los campos requeridos',
      backgroundColor: Colors.indigo[200],
      textColor: Colors.indigo[700],
      gravity: ToastGravity.BOTTOM,
    );
    return;
  }
  Navigator.pushNamed(context, '/home1');
}


  @override
  Widget build(BuildContext context) {
    const double kVerticalPadding = 20.0;
    return Scaffold(
      backgroundColor: Colors.indigo[100],
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: kVerticalPadding),
              Image.asset(
                "lib/images/icono1.png",
                height: 300,
              ),
              TextInput1(
                controller: _userController,
                hint: "Ingrese su usuario",
                obscureText: false,
              ),
              SizedBox(height: kVerticalPadding),
              TextInput1(
                controller: _passwordController,
                hint: "Ingrese su contraseña",
                obscureText: true,
              ),
              SizedBox(height: kVerticalPadding),
              Button1(
                ontap: _signUserIn,
              ),
              SizedBox(height: kVerticalPadding * 2),
              
            ],
          ),
        ),
      ),
    );
  }
}
