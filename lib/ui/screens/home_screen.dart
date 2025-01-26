import 'package:flutter/material.dart';
import 'package:stronglog/domain/models/exercise_model.dart';
import 'package:stronglog/domain/models/workout_model.dart';
import 'package:stronglog/domain/services/exercise_service.dart';
import 'package:stronglog/domain/services/workout_service.dart';
import 'package:stronglog/ui/widgets/drawer_widget.dart';
import 'package:stronglog/ui/widgets/exercise_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                  "Rutina",
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
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  List<Exercise> exercises = snapshot.data!;

                  if (exercises.isEmpty) {
                    return const Center(
                      child: Text('No existen ejercicios aún'),
                    );
                  }

                  return ListView.builder(
                      itemCount: exercises.length,
                      itemBuilder: (context, i) {
                        return ExerciseWidget(
                          exercise: exercises[i],
                        );
                      });
                },
              ),
            )
          ],
        ),
      ),
      drawer: const DrawerWidget(),
    );
  }

  Future<List<Exercise>?> loadData() async {
    String today = _getTodayName();
    WorkoutService workoutService = WorkoutService();
    Workout? workout = await workoutService.getFirstWorkoutByDay(today);
    ExerciseService exerciseService = ExerciseService();
    if (workout != null) {
      return await exerciseService.getExercisesByWorkout(workout.id);
    } else {
      return null;
    }
  }

  String _getTodayName() {
    DateTime now = DateTime.now();
    List<String> days = [
      'Lunes',
      'Martes',
      'Miércoles',
      'Jueves',
      'Viernes',
      'Sábado',
      'Domingo'
    ];

    return days[now.weekday - 1];
  }
}
