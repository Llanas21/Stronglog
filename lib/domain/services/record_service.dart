import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stronglog/domain/models/record_model.dart';

class RecordService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionPath = 'records';

  // Create a new record in Firestore
  Future<void> addRecord(Record record) async {
    try {
      await _firestore.collection(collectionPath).add(record.toJson());
    } catch (e) {
      throw Exception('Error adding record: $e');
    }
  }

  // Read all records from Firestore
  Future<List<Record>> getRecords() async {
    try {
      QuerySnapshot snapshot =
          await _firestore.collection(collectionPath).get();
      return snapshot.docs
          .map((doc) =>
              Record.fromJson(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (e) {
      throw Exception('Error fetching records: $e');
    }
  }

  // Read a single record by ID
  Future<Record?> getRecordById(String id) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection(collectionPath).doc(id).get();
      if (doc.exists) {
        return Record.fromJson(doc.data() as Map<String, dynamic>, doc.id);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Error fetching record: $e');
    }
  }

  // Read a single record by exercise
  Future<Record?> getRecordByExercise(String idExercise) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection(collectionPath)
          .where('id_exercise', isEqualTo: idExercise)
          .orderBy('date_time', descending: true)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot doc = querySnapshot.docs.first;
        return Record.fromJson(doc.data() as Map<String, dynamic>, doc.id);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Error fetching record: $e');
    }
  }

  // Read records from exercise
  Future<List<Record>> getRecordsByExercise(String idExercise) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection(collectionPath)
          .where('id_exercise', isEqualTo: idExercise)
          .orderBy('date_time', descending: false)
          .get();

      return snapshot.docs
          .map((doc) =>
              Record.fromJson(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (e) {
      throw Exception('Error fetching records: $e');
    }
  }

  // Update an existing record
  Future<void> updateRecord(String id, Record updatedRecord) async {
    try {
      await _firestore
          .collection(collectionPath)
          .doc(id)
          .update(updatedRecord.toJson());
    } catch (e) {
      throw Exception('Error updating record: $e');
    }
  }

  // Delete a record
  Future<void> deleteRecord(String id) async {
    try {
      await _firestore.collection(collectionPath).doc(id).delete();
    } catch (e) {
      throw Exception('Error deleting record: $e');
    }
  }
}
