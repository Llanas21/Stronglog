class Workout {
  final String id;
  final String name;
  final String day;

  Workout({
    required this.id,
    required this.name,
    required this.day,
  });

  // Factory method to create an instance from a JSON map
  factory Workout.fromJson(Map<String, dynamic> json, String id) {
    return Workout(
      id: id,
      name: json['name'],
      day: json['day'],
    );
  }

  // Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'day': day,
    };
  }
}
