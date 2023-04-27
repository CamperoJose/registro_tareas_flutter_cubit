import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:registro_tareas_flutter_cubit/components/text_field_design1.dart';
import 'package:registro_tareas_flutter_cubit/components/button_design1.dart';

import '../bl/tasks_cubit.dart';
import 'home1_view.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();

  PendingTasksCubit cubitTasks = PendingTasksCubit();

  void _signUserIn() {
  // Validar que los campos de entrada no estén vacíos
  if (_userController.text.isEmpty || _passwordController.text.isEmpty) {

    return;
  }
  Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
    BlocProvider(
        create: (context) => cubitTasks,
        child: HomeView(),
    ),));
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
