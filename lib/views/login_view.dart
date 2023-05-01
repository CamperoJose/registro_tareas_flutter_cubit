import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:registro_tareas_flutter_cubit/bl/login_cubit.dart';
import '../bl/login_state.dart';
import 'login_form.dart';
import '../components/show_dialog.dart';
import 'home1_view.dart';
import 'package:registro_tareas_flutter_cubit/bl/tasks_cubit.dart';

class LoginView extends StatelessWidget {
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();

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
                ErrorDialog.showErrorDialog(
                  context: context,
                  title: "Error al iniciar sesión",
                  message: "Usuario o contraseña incorrectos.",
                  icon: Icons.error_outline,
                  titleColor: Colors.red,
                  messageColor: Colors.black,
                );
                _userController.clear();
                _passwordController.clear();
              } else if (state.status == LoginStatus.success) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value: BlocProvider.of<TasksCubit>(context),
                      child: BlocProvider.value(
                        value: BlocProvider.of<LoginCubit>(context),
                        child: HomeView(),
                      ),
                    ),
                  ),
                );

              }
            },
            builder: (context, state) {
              if (state.status == LoginStatus.init) {
                return LoginForm();
              } else if (state.status == LoginStatus.loading) {
                return const CircularProgressIndicator(
                  color: Colors.indigo,
                );
              } else {
                return LoginForm();
              }
            },
          ),
        ),
      ),
    );
  }
}
