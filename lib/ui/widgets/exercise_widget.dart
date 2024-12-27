import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:stronglog/domain/models/exercise_model.dart';
import 'package:stronglog/domain/models/record_model.dart' as r;
import 'package:stronglog/domain/services/record_service.dart';

class ExerciseWidget extends StatelessWidget {
  const ExerciseWidget({
    super.key,
    required this.exercise,
  });

  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    r.Record? record;
    TextTheme textTheme = Theme.of(context).textTheme;

    Size mediaQuery = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey[300]!))),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: mediaQuery.width * 0.04,
            vertical: mediaQuery.height * 0.02),
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exercise.muscle,
                      style: textTheme.labelSmall,
                    ),
                    Text(
                      exercise.name,
                      style: textTheme.titleSmall,
                    ),
                    Text(
                      "Tipo: ${exercise.type}",
                      style: textTheme.bodySmall,
                    ),
                    Text(
                      "Equipamiento: ${exercise.equipment}",
                      style: textTheme.bodySmall,
                    )
                  ],
                )),
            Expanded(
                flex: 1,
                child: GestureDetector(
                  child: Column(
                    children: [
                      FutureBuilder(
                        future: loadData(exercise.id!),
                        builder: (BuildContext context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }

                          record = snapshot.data;

                          if (record == null) {
                            return Text(
                              "0 lbs",
                              style: textTheme.titleLarge,
                            );
                          } else {
                            return Text(
                              "${record!.lastWeight.toString()} lbs",
                              style: textTheme.titleLarge,
                            );
                          }
                        },
                      ),
                      Text(
                        "Último peso",
                        style: textTheme.labelSmall,
                      ),
                    ],
                  ),
                  onTap: () => showNumberPicker(context, record),
                ))
          ],
        ),
      ),
    );
  }

  void showNumberPicker(BuildContext context, r.Record? record) {
    TextTheme textTheme = Theme.of(context).textTheme;

    int currentValue;

    if (record == null) {
      currentValue = 0;
    } else {
      currentValue = record.lastWeight;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text(
                'Peso de hoy',
                style: textTheme.bodyMedium,
              ),
              content: NumberPicker(
                minValue: 0,
                maxValue: 600,
                value: currentValue,
                onChanged: (newValue) {
                  setState(() {
                    currentValue = newValue;
                  });
                },
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    //TODO Actualiza el valor del peso en el modelo

                    Navigator.of(context).pop();
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
      },
    );
  }

  Future<r.Record?> loadData(String idExercise) async {
    RecordService recordService = RecordService();

    return await recordService.getRecordByExercise(idExercise);
  }
}
