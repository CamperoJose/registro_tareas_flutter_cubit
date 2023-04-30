import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../bl/tags_cubit.dart';
import '../clases/Tag.dart';
import '../components/appbar_design1.dart';
import '../components/custom_elevated_button.dart';
import '../components/new_tag_button.dart';

class AddTagView extends StatelessWidget {
  final _newTagNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const double kVerticalPadding = 20.0;
    return Scaffold(
      backgroundColor: Colors.indigo[100],
      body: SafeArea(
        child: Column(
          
          
          
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MyAppBar(title: "Editar Etiquetas"),

            Padding(padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: kVerticalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  NewTagButton(
                    onSave: (newTagName) {
                      TagsCubit().addTag(Tag(newTagName));
                      TagsCubit().listedTag();
                    },
                  ),


                  SizedBox(height: 10),

                  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomElevatedButton(
                      buttonText: 'Guardar',
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      primaryColor: Colors.green.shade900,
                    ),
                  ),
                  const SizedBox(width: 20),

                  Expanded(
                    child: CustomElevatedButton(
                      buttonText: 'Cancelar',
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      primaryColor: Colors.red.shade900,
                    ),
                  ),
                ],
              ),

                ],
              ),
            
              
            ),
            
          ],
        ),
      ),
    );
  }
}
