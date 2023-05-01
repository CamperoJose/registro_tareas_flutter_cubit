// login_form.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:registro_tareas_flutter_cubit/components/text_field_design1.dart';

import '../bl/login_cubit.dart';
import '../components/button_design1.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  static const double kVerticalPadding = 20.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: kVerticalPadding),
        Image.asset(
          "lib/images/icono1.png",
          height: 300,
        ),
        TextInput1(
          controller: _userController,
          hint: "Ingrese su usuario",
          obscureText: false,
        ),
        const SizedBox(height: kVerticalPadding),
        TextInput1(
          controller: _passwordController,
          hint: "Ingrese su contraseña",
          obscureText: true,
        ),
        const SizedBox(height: kVerticalPadding),
        Button1(ontap: () {
          if (_userController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
            BlocProvider.of<LoginCubit>(context).login(_userController.text, _passwordController.text);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Por favor ingrese usuario y contraseña")));
          }
        }),
        const SizedBox(height: kVerticalPadding * 2),
      ],
    );
  }
}
