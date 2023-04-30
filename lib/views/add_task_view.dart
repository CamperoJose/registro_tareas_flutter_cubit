import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../bl/task_create_cubit.dart';
import '../bl/task_create_state.dart';
import '../components/appbar_design1.dart';
import 'add_note_form.dart';

class AddNoteView extends StatelessWidget {
  const AddNoteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[100],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const MyAppBar(title: "Registrar Nueva tarea"),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: BlocConsumer<TaskCreateCubit, TaskCreateState>(
                  listener: (context, state) {
                    if (state.status == TaskCreateStatus.failure) {
                      const Text("Error al crear la tarea");
                    } else if (state.status == TaskCreateStatus.success) {
                      Navigator.of(context).pop();
                    }
                  },
                  builder: (context, state) {
                    if (state.status == TaskCreateStatus.loading) {
                      return const Center(child: CircularProgressIndicator(
                  color: Colors.green                ));
                    } else {
                      return AddNoteForm();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  
}
