import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:stronglog/domain/models/exercise_model.dart';
import 'package:stronglog/domain/services/exercise_service.dart';
import 'package:stronglog/main.dart';
import 'package:stronglog/ui/providers/exercise_provider.dart';

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
                  onTap: () {
                    context.pushNamed("/modify_exercise", extra: exercise);
                  },
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
                            onPressed: () => context.pop(),
                            child: Text(
                              "Cancelar",
                              style: textTheme.labelSmall,
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              ExerciseService exerciseService =
                                  ExerciseService();

                              await exerciseService
                                  .deleteExercise(exercise.id!);
                              Provider.of<ExerciseProvider>(context,
                                      listen: false)
                                  .shouldRefresh();

                              context.pop();
                            },
                            child: Text(
                              "Aceptar",
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
