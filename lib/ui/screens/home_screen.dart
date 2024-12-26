import 'package:flutter/material.dart';
import 'package:stronglog/domain/models/exercise_model.dart';
import 'package:stronglog/domain/services/exercise_service.dart';
import 'package:stronglog/domain/services/record_service.dart';
import 'package:stronglog/ui/widgets/drawer_widget.dart';
import 'package:stronglog/ui/widgets/exercise_widget.dart';
import 'package:stronglog/domain/models/record_model.dart' as r;

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
                    return const CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  List<Exercise> exercises = snapshot.data![0];
                  List<r.Record> records = snapshot.data![1];

                  return ListView.builder(
                      itemCount: exercises.length,
                      itemBuilder: (context, i) {
                        return ExerciseWidget(
                          exercise: exercises[i],
                          record: records[i],
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

  Future<List<dynamic>> loadData() async {
    ExerciseService exerciseService = ExerciseService();
    RecordService recordService = RecordService();
    return await Future.wait([
      exerciseService.getExercises(),
      recordService.getRecords(),
    ]);
  }
}
