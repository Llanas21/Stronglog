import 'package:flutter/material.dart';
import 'package:stronglog/domain/models/workout_model.dart';
import 'package:stronglog/domain/services/workout_service.dart';
import 'package:stronglog/ui/widgets/drawer_widget.dart';
import 'package:stronglog/ui/widgets/workout_widget.dart';

class WorkoutsScreen extends StatelessWidget {
  const WorkoutsScreen({super.key});

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
                  "Rutinas",
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

                  List<Workout> workouts = snapshot.data!;

                  return ListView.builder(
                      itemCount: workouts.length,
                      itemBuilder: (context, i) {
                        return WorkoutWidget(workout: workouts[i]);
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

  Future<List<Workout>> loadData() async {
    WorkoutService workoutService = WorkoutService();
    return await workoutService.getWorkouts();
  }
}
