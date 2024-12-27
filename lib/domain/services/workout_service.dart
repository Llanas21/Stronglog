import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stronglog/domain/models/workout_model.dart';

class WorkoutService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionPath = 'workouts';

  // Crear un nuevo workout en Firestore
  Future<void> addWorkout(Workout workout) async {
    try {
      await _firestore.collection(collectionPath).add(workout.toJson());
    } catch (e) {
      throw Exception('Error al agregar workout: $e');
    }
  }

  // Leer todos los workouts de Firestore
  Future<List<Workout>> getWorkouts() async {
    try {
      QuerySnapshot snapshot =
          await _firestore.collection(collectionPath).get();
      return snapshot.docs
          .map((doc) =>
              Workout.fromJson(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (e) {
      throw Exception('Error al obtener workouts: $e');
    }
  }

  // Leer workouts por día específico
  Future<List<Workout>> getWorkoutsByDay(String day) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection(collectionPath)
          .where('day', isEqualTo: day)
          .get();
      return snapshot.docs
          .map((doc) =>
              Workout.fromJson(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (e) {
      throw Exception('Error al obtener workouts por día: $e');
    }
  }

  // Leer un workout específico por ID
  Future<Workout?> getWorkoutById(String id) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection(collectionPath).doc(id).get();
      if (doc.exists) {
        return Workout.fromJson(doc.data() as Map<String, dynamic>, doc.id);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Error al obtener workout: $e');
    }
  }

  // Actualizar un workout existente
  Future<void> updateWorkout(String id, Workout updatedWorkout) async {
    try {
      await _firestore
          .collection(collectionPath)
          .doc(id)
          .update(updatedWorkout.toJson());
    } catch (e) {
      throw Exception('Error al actualizar workout: $e');
    }
  }

  // Eliminar un workout
  Future<void> deleteWorkout(String id) async {
    try {
      await _firestore.collection(collectionPath).doc(id).delete();
    } catch (e) {
      throw Exception('Error al eliminar workout: $e');
    }
  }
}
