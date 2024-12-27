import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stronglog/domain/models/exercise_model.dart';

class ExerciseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionPath = 'exercises';

  // Create a new exercise in Firestore
  Future<void> addExercise(Exercise exercise) async {
    try {
      await _firestore.collection(collectionPath).add(exercise.toJson());
    } catch (e) {
      throw Exception('Error adding exercise: $e');
    }
  }

  // Read all exercises from Firestore
  Future<List<Exercise>> getExercises() async {
    try {
      QuerySnapshot snapshot =
          await _firestore.collection(collectionPath).get();
      return snapshot.docs
          .map((doc) =>
              Exercise.fromJson(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (e) {
      throw Exception('Error fetching exercises: $e');
    }
  }

  // Read exercises from workout
  Future<List<Exercise>> getExercisesByWorkout(String idWorkout) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection(collectionPath)
          .where('id_workout', isEqualTo: idWorkout)
          .get();
      return snapshot.docs
          .map((doc) =>
              Exercise.fromJson(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (e) {
      throw Exception('Error fetching exercises: $e');
    }
  }

  // Read a single exercise by ID
  Future<Exercise?> getExerciseById(String id) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection(collectionPath).doc(id).get();
      if (doc.exists) {
        return Exercise.fromJson(doc.data() as Map<String, dynamic>, doc.id);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Error fetching exercise: $e');
    }
  }

  // Update an existing exercise
  Future<void> updateExercise(String id, Exercise updatedExercise) async {
    try {
      await _firestore
          .collection(collectionPath)
          .doc(id)
          .update(updatedExercise.toJson());
    } catch (e) {
      throw Exception('Error updating exercise: $e');
    }
  }

  // Delete an exercise
  Future<void> deleteExercise(String id) async {
    try {
      await _firestore.collection(collectionPath).doc(id).delete();
    } catch (e) {
      throw Exception('Error deleting exercise: $e');
    }
  }
}
