class Category {
  final String id; // Unique identifier for the category
  final String name;

  Category({
    required this.id,
    required this.name,
  });

  // Factory constructor for creating a Category object from a map
  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      name: map['name'],
    );
  }

  // Method to convert Category object to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}
