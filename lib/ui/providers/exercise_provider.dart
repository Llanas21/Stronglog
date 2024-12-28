import 'package:flutter/material.dart';
import 'package:stronglog/domain/models/exercise_model.dart';
import 'package:stronglog/domain/services/exercise_service.dart';

class ExerciseProvider with ChangeNotifier {
  late Future<List<Exercise>> _exercises;
  final ExerciseService exerciseService = ExerciseService();

  Future<List<Exercise>> get exercises {
    return _exercises;
  }

  set exercises(Future<List<Exercise>> exercises) {
    _exercises = exercises;
    notifyListeners();
  }

  void shouldRefresh() {
    notifyListeners();
  }
}
