class Note {
  final String? id;
  final String note;
  final String idExercise;
  final String uidUser;

  Note({
    this.id,
    required this.note,
    required this.idExercise,
    required this.uidUser,
  });

  // Factory method to create an instance from a JSON map
  factory Note.fromJson(Map<String, dynamic> json, String id) {
    return Note(
      id: id,
      note: json['note'],
      idExercise: json['id_exercise'],
      uidUser: json['uid_user'],
    );
  }

  // Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'note': note,
      'id_exercise': idExercise,
      'uid_user': uidUser,
    };
  }

  // Method to create a copy of an instance with updated fields
  Note copyWith({
    String? id,
    String? note,
    String? idExercise,
    String? uidUser,
  }) {
    return Note(
      id: id ?? this.id,
      note: note ?? this.note,
      idExercise: idExercise ?? this.idExercise,
      uidUser: uidUser ?? this.uidUser,
    );
  }
}
