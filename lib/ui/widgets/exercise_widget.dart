import 'package:flutter/material.dart';
import 'package:stronglog/domain/models/exercise_model.dart';
import 'package:stronglog/domain/models/record_model.dart' as r;

class ExerciseWidget extends StatelessWidget {
  const ExerciseWidget({
    super.key,
    required this.exercise,
    required this.record,
  });

  final Exercise exercise;
  final r.Record record;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    Size mediaQuery = MediaQuery.of(context).size;

    return Container(
      decoration: const BoxDecoration(border: Border(bottom: BorderSide())),
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
                child: Column(
                  children: [
                    Text(
                      "${record.lastWeight.toString()} lbs",
                      style: textTheme.titleLarge,
                    ),
                    Text(
                      "Último peso",
                      style: textTheme.labelSmall,
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
