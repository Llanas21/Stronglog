class Exercise {
  final String id;
  final String name;
  final String type;
  final String muscle;
  final String equipment;
  final String difficulty;
  final String instructions;
  final String idWorkout;

  Exercise(
      {required this.id,
      required this.name,
      required this.type,
      required this.muscle,
      required this.equipment,
      required this.difficulty,
      required this.instructions,
      required this.idWorkout});

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
      idWorkout: json['id_workout'],
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
      'id_workout': idWorkout,
    };
  }
}
