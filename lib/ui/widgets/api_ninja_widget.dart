import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stronglog/domain/models/api_ninja_model.dart';
import 'package:stronglog/ui/providers/add_exercise_provider.dart';

class ApiNinjaWidget extends StatefulWidget {
  const ApiNinjaWidget({
    super.key,
    required this.exercise,
  });

  final ApiNinja exercise;

  @override
  State<ApiNinjaWidget> createState() => _ApiNinjaWidgetState();
}

class _ApiNinjaWidgetState extends State<ApiNinjaWidget> {
  late bool isSelected;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    Size mediaQuery = MediaQuery.of(context).size;

    return Consumer(
      builder: (context, AddExerciseProvider addExerciseProvider, child) {
        List<ApiNinja> selectedExercises = addExerciseProvider.exercises;
        selectedExercises.contains(widget.exercise)
            ? isSelected = true
            : isSelected = false;

        return Container(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey[300]!))),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: mediaQuery.width * 0.04,
                vertical: mediaQuery.height * 0.02),
            child: Row(
              children: [
                Checkbox(
                  value: isSelected,
                  onChanged: (bool? value) {
                    setState(() {
                      isSelected = value ?? false;
                    });
                    if (isSelected) {
                      Provider.of<AddExerciseProvider>(context, listen: false)
                          .addExercise(widget.exercise);
                    } else {
                      Provider.of<AddExerciseProvider>(context, listen: false)
                          .removeExercise(widget.exercise);
                    }
                  },
                ),
                SizedBox(
                  width: mediaQuery.width * 0.04,
                ),
                Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.exercise.muscle,
                          style: textTheme.labelSmall,
                        ),
                        Text(
                          widget.exercise.name,
                          style: textTheme.titleSmall,
                        ),
                        Text(
                          "Tipo: ${widget.exercise.type}",
                          style: textTheme.bodySmall,
                        ),
                        Text(
                          "Equipamiento: ${widget.exercise.equipment}",
                          style: textTheme.bodySmall,
                        )
                      ],
                    )),
              ],
            ),
          ),
        );
      },
    );
  }
}
