import 'package:cloud_firestore/cloud_firestore.dart';

class Record {
  final String? id;
  final int lastWeight;
  final DateTime dateTime;
  final String idExercise;
  final String uidUser;

  Record(
      {this.id,
      required this.lastWeight,
      required this.dateTime,
      required this.idExercise,
      required this.uidUser});

  // Factory method to create an instance from a JSON map
  factory Record.fromJson(Map<String, dynamic> json, String id) {
    return Record(
      id: id,
      lastWeight: (json['last_weight'] as num).toInt(),
      dateTime: (json['date_time'] as Timestamp).toDate(),
      idExercise: json['id_exercise'],
      uidUser: json['uid_user'],
    );
  }

  // Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'last_weight': lastWeight,
      'date_time': Timestamp.fromDate(dateTime),
      'id_exercise': idExercise,
      'uid_user': uidUser,
    };
  }
}
