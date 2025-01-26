import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stronglog/domain/models/note_model.dart';

class NoteService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionPath = 'notes';

  // Create a new note in Firestore
  Future<void> addNote(Note note) async {
    try {
      await _firestore.collection(collectionPath).add(note.toJson());
    } catch (e) {
      throw Exception('Error adding note: $e');
    }
  }

  // Read all notes from Firestore
  Future<List<Note>> getNotes() async {
    try {
      QuerySnapshot snapshot =
          await _firestore.collection(collectionPath).get();
      return snapshot.docs
          .map((doc) =>
              Note.fromJson(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (e) {
      throw Exception('Error fetching notes: $e');
    }
  }

  // Read notes by exercise ID
  Future<List<Note>> getNotesByExercise(String idExercise) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection(collectionPath)
          .where('id_exercise', isEqualTo: idExercise)
          .get();
      return snapshot.docs
          .map((doc) =>
              Note.fromJson(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (e) {
      throw Exception('Error fetching notes: $e');
    }
  }

  // Read a single note by ID
  Future<Note?> getNoteById(String id) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection(collectionPath).doc(id).get();
      if (doc.exists) {
        return Note.fromJson(doc.data() as Map<String, dynamic>, doc.id);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Error fetching note: $e');
    }
  }

  // Update an existing note
  Future<void> updateNote(String id, Note updatedNote) async {
    try {
      await _firestore
          .collection(collectionPath)
          .doc(id)
          .update(updatedNote.toJson());
    } catch (e) {
      throw Exception('Error updating note: $e');
    }
  }

  // Delete a note
  Future<void> deleteNote(String id) async {
    try {
      await _firestore.collection(collectionPath).doc(id).delete();
    } catch (e) {
      throw Exception('Error deleting note: $e');
    }
  }
}
