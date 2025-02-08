class Preference {
  final int id; // Add this field to match the backend
  final String name;
  final String photo; // Changed from imageUrl to photo
  bool selected;

  Preference({
    required this.id,
    required this.name,
    required this.photo,
    required this.selected,
  });

  factory Preference.fromJson(Map<String, dynamic> json) {
    return Preference(
      id: json['id'] ?? 0, // Parse ID from the backend
      name: json['name'] ?? '',
      photo: json['photo'] ?? '', 
      selected: json['is_preferred'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'photo': photo, // Changed from imageUrl to photo
      'is_preferred': selected,
    };
  }
}
