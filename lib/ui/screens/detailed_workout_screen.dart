import 'package:flutter/material.dart';
import 'package:stronglog/domain/models/exercise_model.dart';
import 'package:stronglog/domain/models/workout_model.dart';
import 'package:stronglog/domain/services/exercise_service.dart';
import 'package:stronglog/ui/widgets/detailed_workout_widget.dart';
import 'package:stronglog/ui/widgets/drawer_widget.dart';

class DetailedWorkoutScreen extends StatelessWidget {
  const DetailedWorkoutScreen({
    super.key,
    required this.workout,
  });

  final Workout workout;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    Size mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
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
                  "Rutina del ${workout.day}",
                  style: textTheme.titleLarge,
                ),
              ),
            ),
            SizedBox(
              height: mediaQuery.height * 0.04,
            ),
            Expanded(
              child: FutureBuilder(
                future: loadData(),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  List<Exercise> exercises = snapshot.data!;

                  if (exercises.isEmpty) {
                    return const Center(
                      child: Text("No hay ejercicios para este día"),
                    );
                  } else {
                    return ListView.builder(
                        itemCount: exercises.length,
                        itemBuilder: (context, i) {
                          return DetailedWorkoutWidget(
                            exercise: exercises[i],
                          );
                        });
                  }
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton:
          FloatingActionButton(child: const Icon(Icons.add), onPressed: () {}),
      drawer: const DrawerWidget(),
    );
  }

  Future<List<Exercise>> loadData() async {
    ExerciseService exerciseService = ExerciseService();
    return await exerciseService.getExercisesByWorkout(workout.id);
  }
}
