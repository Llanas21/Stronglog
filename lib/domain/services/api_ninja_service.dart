import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stronglog/domain/models/api_ninja_model.dart';

class ApiNinjaService {
  final String apiKey = 'jDQTW5bNKjj8shU4d4Esug==5gXLqVRWUbwhDEk9';
  final String baseUrl = 'https://api.api-ninjas.com/v1/exercises';

  // Método para obtener ejercicios por músculo
  Future<List<ApiNinja>> fetchExercisesByMuscle(String muscle) async {
    final response = await http.get(
      Uri.parse('$baseUrl?muscle=$muscle'),
      headers: {
        'X-Api-Key': apiKey,
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => ApiNinja.fromJson(json)).toList();
    } else {
      throw Exception(
          'Error al obtener ejercicios para $muscle: ${response.reasonPhrase}');
    }
  }

  // Método para obtener ejercicios de todos los músculos
  Future<List<ApiNinja>> fetchExercisesForAllMuscles() async {
    final List<String> muscles = [
      'abdominals',
      'abductors',
      'adductors',
      'biceps',
      'calves',
      'chest',
      'forearms',
      'glutes',
      'hamstrings',
      'lats',
      'lower_back',
      'middle_back',
      'neck',
      'quadriceps',
      'traps',
      'triceps'
    ];

    List<ApiNinja> allExercises = [];

    for (String muscle in muscles) {
      try {
        List<ApiNinja> exercises = await fetchExercisesByMuscle(muscle);
        allExercises.addAll(exercises);
      } catch (e) {
        print('Error al obtener ejercicios para $muscle: $e');
      }
    }

    return allExercises;
  }
}
