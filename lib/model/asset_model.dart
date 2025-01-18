class Asset {
  final int? id;
  final String name;
  final String type;
  final String description;
  final String availability;

  Asset({
    this.id,
    required this.name,
    required this.type,
    required this.description,
    required this.availability,
  });

  // Convert a Asset object into a Map object for SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'description': description,
      'availability': availability,
    };
  }

  // Extract an Asset object from a Map object (for SQLite retrieval)
  factory Asset.fromMap(Map<String, dynamic> map) {
    return Asset(
      id: map['id'],
      name: map['name'],
      type: map['type'],
      description: map['description'],
      availability: map['availability'],
    );
  }
}
