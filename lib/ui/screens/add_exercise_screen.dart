import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:stronglog/domain/models/api_ninja_model.dart';
import 'package:stronglog/domain/models/exercise_model.dart';
import 'package:stronglog/domain/models/workout_model.dart';
import 'package:stronglog/domain/services/api_ninja_service.dart';
import 'package:stronglog/domain/services/auth_service.dart';
import 'package:stronglog/domain/services/exercise_service.dart';
import 'package:stronglog/ui/providers/add_exercise_provider.dart';
import 'package:stronglog/ui/widgets/api_ninja_widget.dart';

class AddExerciseScreen extends StatefulWidget {
  const AddExerciseScreen({super.key, required this.workout});

  final Workout workout;

  @override
  State<AddExerciseScreen> createState() => _AddExerciseScreenState();
}

class _AddExerciseScreenState extends State<AddExerciseScreen> {
  late Future<List<ApiNinja>> futureData;
  List<ApiNinja> exercises = [];

  TextEditingController searchController = TextEditingController();
  List<ApiNinja> filteredExercises = [];

  final List<String> muscles = [
    'abdominals',
    'abductors',
    'adductors',
    'biceps',
    'calves',
    'chest',
    'forearms',
    'glutes',
    'hamstrings',
    'lats',
    'lower_back',
    'middle_back',
    'neck',
    'quadriceps',
    'traps',
    'triceps'
  ];

  String? selectedMuscle;

  @override
  void initState() {
    super.initState();
    futureData = loadData();
    searchController.addListener(_filterExercises);
  }

  // Método para filtrar los ejercicios según el texto de búsqueda
  void _filterExercises() {
    print(selectedMuscle);
    String query = searchController.text.toLowerCase();
    setState(() {
      if (selectedMuscle != null && searchController.text.isEmpty) {
        filteredExercises = exercises.where((exercise) {
          return exercise.muscle == selectedMuscle;
        }).toList();
        for (var exercise in filteredExercises) {
          print(exercise.muscle);
        }
      } else {
        filteredExercises = exercises.where((exercise) {
          return exercise.name.toLowerCase().contains(query) &&
              (selectedMuscle == null || exercise.muscle == selectedMuscle);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    Size mediaQuery = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () => showPopConfirmation(context),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            PopupMenuButton<String>(
              itemBuilder: (BuildContext context) => [
                PopupMenuItem<String>(
                  onTap: () {
                    context.pushNamed('/new_exercise');
                  },
                  child: Text(
                    'Nuevo ejercicio',
                    style: textTheme.bodyMedium,
                  ),
                ),
              ],
              icon: const Icon(Icons.more_vert_outlined),
            ),
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(border: Border(top: BorderSide())),
          child: Column(
            children: [
              SizedBox(
                height: mediaQuery.height * 0.04,
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: mediaQuery.width * 0.04),
                child: SearchBar(
                  controller: searchController,
                  backgroundColor:
                      const WidgetStatePropertyAll(Colors.transparent),
                  elevation: const WidgetStatePropertyAll(0.0),
                  hintText: 'Buscar',
                  leading: const Icon(Icons.search),
                  shape: const WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                  ),
                  side: const WidgetStatePropertyAll(
                      BorderSide(color: Colors.black)),
                ),
              ),
              SizedBox(
                height: mediaQuery.height * 0.02,
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: mediaQuery.width * 0.04),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: muscles.map((muscle) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 6.0),
                        child: ChoiceChip(
                          label: Text(muscle),
                          selected: selectedMuscle == muscle,
                          onSelected: (isSelected) {
                            setState(() {
                              selectedMuscle = isSelected ? muscle : null;
                              _filterExercises();
                            });
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(
                height: mediaQuery.height * 0.02,
              ),
              Expanded(
                child: FutureBuilder(
                  future: futureData,
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    exercises = snapshot.data!;

                    // Si no hay texto de búsqueda y no hay músculo seleccionado, mostramos todos los ejercicios
                    if (selectedMuscle == null &&
                        searchController.text.isEmpty) {
                      filteredExercises = exercises;
                    }

                    if (filteredExercises.isEmpty) {
                      return const Center(
                        child: Text("No hay ejercicios"),
                      );
                    } else {
                      return ListView.builder(
                          itemCount: filteredExercises.length,
                          itemBuilder: (context, i) {
                            return ApiNinjaWidget(
                              exercise: filteredExercises[i],
                            );
                          });
                    }
                  },
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
                    onPressed: () => showConfirmation(context),
                    child: const Text(
                      'Agregar ejercicios',
                    ),
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
    List<ApiNinja> selectedExercises =
        Provider.of<AddExerciseProvider>(context, listen: false).exercises;

    if (selectedExercises.isNotEmpty) {
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
                    Provider.of<AddExerciseProvider>(context, listen: false)
                        .clearExercises();
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

  void showConfirmation(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    List<ApiNinja> exercises =
        Provider.of<AddExerciseProvider>(context, listen: false).exercises;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Añadirás estos ejercicios a tu rutina...',
            style: textTheme.bodyMedium,
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: ListBody(
                children: exercises.map((exercise) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey[200]!,
                        ),
                      ),
                    ),
                    child: ListTile(
                      title: Text(
                        exercise.name,
                        style: textTheme.bodySmall,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                ExerciseService exerciseService = ExerciseService();
                AuthService authService = AuthService();
                String uidUser = authService.currentUser!.uid;

                for (ApiNinja apiExercise in exercises) {
                  Exercise exercise = Exercise(
                    name: apiExercise.name,
                    type: apiExercise.type,
                    muscle: apiExercise.muscle,
                    equipment: apiExercise.equipment,
                    difficulty: apiExercise.difficulty,
                    instructions: apiExercise.instructions,
                    idWorkout: widget.workout.id,
                    uidUser: uidUser,
                  );

                  await exerciseService.addExercise(exercise);
                }

                context.goNamed("/detailed_workout", extra: widget.workout);
              },
              child: Text(
                'Aceptar',
                style: textTheme.labelSmall?.copyWith(color: Colors.black),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancelar',
                style: textTheme.labelSmall,
              ),
            ),
          ],
        );
      },
    );
  }

  Future<List<ApiNinja>> loadData() async {
    ApiNinjaService apiNinjaService = ApiNinjaService();
    return await apiNinjaService.fetchExercisesForAllMuscles();
  }
}
