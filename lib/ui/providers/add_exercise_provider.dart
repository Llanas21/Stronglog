import 'package:flutter/material.dart';
import 'package:stronglog/domain/models/api_ninja_model.dart';

class AddExerciseProvider with ChangeNotifier {
  // Lista de objetos ApiNinja
  List<ApiNinja> _exercises = [];

  // Getter para obtener la lista de ejercicios
  List<ApiNinja> get exercises => _exercises;

  // Método para agregar un nuevo ejercicio a la lista
  void addExercise(ApiNinja exercise) {
    _exercises.add(exercise);
    notifyListeners();
  }

  // Método para eliminar un ejercicio de la lista
  void removeExercise(ApiNinja exercise) {
    _exercises.remove(exercise);
    notifyListeners();
  }
}
