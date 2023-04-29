import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:registro_tareas_flutter_cubit/bl/login_cubit.dart';
import 'package:registro_tareas_flutter_cubit/components/text_field_design1.dart';
import 'package:registro_tareas_flutter_cubit/components/button_design1.dart';
import '../bl/login_state.dart';
import '../bl/tasks_cubit.dart';
import 'home1_view.dart';

class LoginView extends StatelessWidget {
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();

  PendingTasksCubit cubitTasks = PendingTasksCubit();

  LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[100],
      body: SafeArea(
        child: Center(
          child: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state.status == LoginStatus.failure) {
                _showErrorDialog(
                context: context,
                title: "Error al iniciar sesión",
                message: "Usuario o contraseña incorrectos.",
                icon: Icons.error_outline, // Icono de error personalizado (opcional)
                titleColor: Colors.red, // Color del tíRtulo (opcional)
                messageColor: Colors.black, // Color del mensaje (opcional)
              );
              _userController.clear();
              _passwordController.clear();
              }
            },
            builder: (context, state) {
              if (state.status == LoginStatus.init) {
                return _loginForm(context);
              } else if (state.status == LoginStatus.loading) {
                return const CircularProgressIndicator();
              } else if (state.status == LoginStatus.success) {
                return BlocProvider(
                  create: (context) => cubitTasks,
                  child: HomeView(),
                );
              } else {
                return _loginForm(context);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _loginForm(BuildContext context) {
    const double kVerticalPadding = 20.0;
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


void _showErrorDialog({
  required BuildContext context,
  required String title,
  required String message,
  IconData? icon,
  Color? titleColor,
  Color? messageColor,
  TextStyle? titleTextStyle,
  TextStyle? messageTextStyle,
  String? additionalButtonText,
  VoidCallback? onAdditionalButtonPressed,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(
          children: [
            icon != null
                ? Icon(icon, color: titleColor ?? Colors.red)
                : Container(),
            SizedBox(width: icon != null ? 8.0 : 0.0),
            Text(
              title,
              style: titleTextStyle ??
                  TextStyle(
                    color: titleColor ?? Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
        content: Text(
          message,
          style: messageTextStyle ??
              TextStyle(
                color: messageColor ?? Colors.black,
              ),
        ),
        actions: <Widget>[
          if (additionalButtonText != null && onAdditionalButtonPressed != null)
            TextButton(
              child: Text(additionalButtonText),
              onPressed: onAdditionalButtonPressed,
            ),
          TextButton(
            child: const Text('Aceptar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

}
