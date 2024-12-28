class Exercise {
  final String? id;
  final String name;
  final String type;
  final String muscle;
  final String equipment;
  final String difficulty;
  final String instructions;
  final int? sets;
  final int? reps;
  final String idWorkout;
  final String uidUser;

  Exercise(
      {this.id,
      required this.name,
      required this.type,
      required this.muscle,
      required this.equipment,
      required this.difficulty,
      required this.instructions,
      this.sets,
      this.reps,
      required this.idWorkout,
      required this.uidUser});

  // Factory method to create an instance from a JSON map
  factory Exercise.fromJson(Map<String, dynamic> json, String id) {
    return Exercise(
      id: id,
      name: json['name'],
      type: json['type'],
      muscle: json['muscle'],
      equipment: json['equipment'],
      difficulty: json['difficulty'],
      instructions: json['instructions'],
      sets: (json['sets'] as num?)?.toInt() ?? 0,
      reps: (json['reps'] as num?)?.toInt() ?? 0,
      idWorkout: json['id_workout'],
      uidUser: json['uid_user'],
    );
  }

  // Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
      'muscle': muscle,
      'equipment': equipment,
      'difficulty': difficulty,
      'instructions': instructions,
      'sets': sets,
      'reps': reps,
      'id_workout': idWorkout,
      'uid_user': uidUser,
    };
  }

  // Method to create a copy of an instance with updated fields
  Exercise copyWith({
    String? id,
    String? name,
    String? type,
    String? muscle,
    String? equipment,
    String? difficulty,
    String? instructions,
    int? sets,
    int? reps,
    String? idWorkout,
    String? uidUser,
  }) {
    return Exercise(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      muscle: muscle ?? this.muscle,
      equipment: equipment ?? this.equipment,
      difficulty: difficulty ?? this.difficulty,
      instructions: instructions ?? this.instructions,
      sets: sets ?? this.sets,
      reps: reps ?? this.reps,
      idWorkout: idWorkout ?? this.idWorkout,
      uidUser: uidUser ?? this.uidUser,
    );
  }
}
