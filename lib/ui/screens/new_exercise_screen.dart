import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:stronglog/domain/models/api_ninja_model.dart';
import 'package:stronglog/domain/models/exercise_model.dart';
import 'package:stronglog/ui/providers/add_exercise_provider.dart';

class NewExerciseScreen extends StatefulWidget {
  const NewExerciseScreen({super.key});

  @override
  State<NewExerciseScreen> createState() => _NewExerciseScreenState();
}

class _NewExerciseScreenState extends State<NewExerciseScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController muscleController = TextEditingController();
  TextEditingController equipmentController = TextEditingController();
  TextEditingController difficultyController = TextEditingController();
  TextEditingController instructionsController = TextEditingController();

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
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      inputDecorationTheme: const InputDecorationTheme(
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                    child: TextField(
                      onTapOutside: (_) =>
                          FocusScope.of(context).requestFocus(FocusNode()),
                      controller: nameController,
                      style: textTheme.titleLarge,
                      decoration: const InputDecoration(
                        hintText: 'Nuevo Ejercicio',
                      ),
                    ),
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
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          TextFormField(
                            onTapOutside: (_) => FocusScope.of(context)
                                .requestFocus(FocusNode()),
                            controller: typeController,
                            style: textTheme.bodyMedium,
                            decoration: const InputDecoration(
                              labelText: 'Tipo',
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
                            onTapOutside: (_) => FocusScope.of(context)
                                .requestFocus(FocusNode()),
                            controller: muscleController,
                            style: textTheme.bodyMedium,
                            decoration: const InputDecoration(
                              labelText: 'Músculo',
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
                            onTapOutside: (_) => FocusScope.of(context)
                                .requestFocus(FocusNode()),
                            controller: equipmentController,
                            style: textTheme.bodyMedium,
                            decoration: const InputDecoration(
                              labelText: 'Equipamiento',
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
                            onTapOutside: (_) => FocusScope.of(context)
                                .requestFocus(FocusNode()),
                            controller: difficultyController,
                            style: textTheme.bodyMedium,
                            decoration: const InputDecoration(
                              labelText: 'Dificultad',
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
                            onTapOutside: (_) => FocusScope.of(context)
                                .requestFocus(FocusNode()),
                            controller: instructionsController,
                            style: textTheme.bodyMedium,
                            decoration: const InputDecoration(
                              labelText: 'Instrucciones',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Este campo es obligatorio';
                              }
                              return null;
                            },
                            maxLines: 3,
                          ),
                        ],
                      ),
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
                      if (_formKey.currentState!.validate()) {
                        ApiNinja exercise = ApiNinja(
                          name: nameController.text,
                          type: typeController.text,
                          muscle: muscleController.text,
                          equipment: equipmentController.text,
                          difficulty: difficultyController.text,
                          instructions: instructionsController.text,
                        );
                        Provider.of<AddExerciseProvider>(context, listen: false)
                            .addExercise(exercise);
                        context.pop();
                      }
                    },
                    child: const Text('Añadir'),
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

    if (nameController.text.isNotEmpty ||
        typeController.text.isNotEmpty ||
        muscleController.text.isNotEmpty ||
        equipmentController.text.isNotEmpty ||
        difficultyController.text.isNotEmpty ||
        instructionsController.text.isNotEmpty) {
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
