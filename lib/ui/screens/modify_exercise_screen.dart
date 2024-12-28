import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stronglog/domain/models/exercise_model.dart';
import 'package:stronglog/domain/services/exercise_service.dart';

class ModifyExerciseScreen extends StatefulWidget {
  const ModifyExerciseScreen({super.key, required this.exercise});

  final Exercise exercise;

  @override
  State<ModifyExerciseScreen> createState() => _ModifyExerciseScreenState();
}

class _ModifyExerciseScreenState extends State<ModifyExerciseScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController setsController = TextEditingController();
  TextEditingController repsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    Size mediaQuery = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () => showPopConfirmation(context),
      child: Scaffold(
        appBar: AppBar(),
        body: Container(
          decoration: const BoxDecoration(border: Border(top: BorderSide())),
          child: Column(
            children: [
              SizedBox(
                height: mediaQuery.height * 0.04,
              ),
              Padding(
                padding: EdgeInsets.only(left: mediaQuery.width * 0.06),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.exercise.name,
                    style: textTheme.titleLarge,
                  ),
                ),
              ),
              SizedBox(height: mediaQuery.height * 0.04),
              Expanded(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: mediaQuery.width * 0.02),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          onTapOutside: (_) =>
                              FocusScope.of(context).requestFocus(FocusNode()),
                          controller: setsController,
                          style: textTheme.bodyMedium,
                          decoration: const InputDecoration(
                            labelText: 'Sets',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Este campo es obligatorio';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: mediaQuery.height * 0.04),
                        TextFormField(
                          onTapOutside: (_) =>
                              FocusScope.of(context).requestFocus(FocusNode()),
                          controller: repsController,
                          style: textTheme.bodyMedium,
                          decoration: const InputDecoration(
                            labelText: 'Reps',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Este campo es obligatorio';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: mediaQuery.height * 0.01,
                    horizontal: mediaQuery.width * 0.04),
                child: SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () async {
                      ExerciseService exerciseService = ExerciseService();

                      Exercise exercise = widget.exercise.copyWith(
                        sets: int.parse(setsController.text),
                        reps: int.parse(repsController.text),
                      );

                      await exerciseService.updateExercise(
                          exercise.id!, exercise);

                      context.pop();
                    },
                    child: const Text('Guardar'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> showPopConfirmation(BuildContext context) async {
    TextTheme textTheme = Theme.of(context).textTheme;

    if (setsController.text.isNotEmpty || repsController.text.isNotEmpty) {
      return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                '¿Descartar cambios?',
                style: textTheme.bodyMedium,
              ),
              content: Text(
                '¿Seguro que quieres salir y descartar los cambios?',
                style: textTheme.bodySmall,
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    'Cancelar',
                    style: textTheme.labelSmall?.copyWith(color: Colors.black),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text(
                    'Descartar',
                    style: textTheme.labelSmall,
                  ),
                ),
              ],
            ),
          ) ??
          false;
    } else {
      return true;
    }
  }
}
