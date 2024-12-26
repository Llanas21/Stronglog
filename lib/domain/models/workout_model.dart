import 'package:stronglog/domain/models/exercise_model.dart';

class Workout {
  final String id;
  final String day;
  final List<Exercise> exercises;

  Workout({
    required this.id,
    required this.day,
    required this.exercises,
  });

  // Factory method to create an instance from a JSON map
  factory Workout.fromJson(Map<String, dynamic> json, String id) {
    return Workout(
      id: id,
      day: json['day'],
      exercises: (json['exercises'] as List)
          .map((exerciseJson) => Exercise.fromJson(
              exerciseJson as Map<String, dynamic>, exerciseJson['id']))
          .toList(),
    );
  }

  // Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'day': day,
      'exercises': exercises.map((exercise) => exercise.toJson()).toList(),
    };
  }
}
