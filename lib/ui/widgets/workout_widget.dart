import 'package:flutter/material.dart';
import 'package:stronglog/domain/models/workout_model.dart';

class WorkoutWidget extends StatelessWidget {
  const WorkoutWidget({
    super.key,
    required this.workout,
  });

  final Workout workout;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    Size mediaQuery = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey[300]!))),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: mediaQuery.width * 0.06,
            vertical: mediaQuery.height * 0.04),
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      workout.name,
                      style: textTheme.labelSmall,
                    ),
                    SizedBox(
                      height: mediaQuery.height * 0.006,
                    ),
                    Text(
                      workout.day,
                      style: textTheme.bodyMedium,
                    ),
                  ],
                )),
            Expanded(
                flex: 1,
                child: GestureDetector(
                  child: const Align(
                      alignment: Alignment.centerRight,
                      child: Icon(Icons.keyboard_arrow_right)),
                  onTap: () {},
                ))
          ],
        ),
      ),
    );
  }
}
