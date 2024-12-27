import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:stronglog/domain/models/exercise_model.dart';
import 'package:stronglog/domain/models/record_model.dart' as r;
import 'package:stronglog/domain/services/record_service.dart';

class DetailedWorkoutWidget extends StatelessWidget {
  const DetailedWorkoutWidget({
    super.key,
    required this.exercise,
  });

  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
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
            PopupMenuButton<String>(
              itemBuilder: (BuildContext context) => [
                PopupMenuItem<String>(
                  onTap: () {},
                  child: Text(
                    'Editar',
                    style: textTheme.bodyMedium,
                  ),
                ),
                PopupMenuItem<String>(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: Text(
                          "¿Estás seguro de que deseas eliminar este ejercicio?",
                          style: textTheme.bodyMedium,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "SI",
                              style: textTheme.labelSmall,
                            ),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              "NO",
                              style: textTheme.labelSmall
                                  ?.copyWith(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Text(
                    'Borrar',
                    style: textTheme.bodyMedium,
                  ),
                ),
              ],
              icon: const Icon(Icons.more_vert_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
