class Preference {
  final int id; // Add this field to match the backend
  final String name;
  final String photo; // Changed from imageUrl to photo
  bool selected;

  Preference({
    required this.id,
    required this.name,
    required this.photo,
    this.selected = false,
  });

  factory Preference.fromJson(Map<String, dynamic> json) {
    return Preference(
      id: json['id'] ?? 0, // Parse ID from the backend
      name: json['name'] ?? '',
      photo: json['photo'] ?? '', 
      selected: json['selected'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'photo': photo, // Changed from imageUrl to photo
      'selected': selected,
    };
  }
}



/* class Preference {
  final String name;
  final String imageUrl;
  bool selected;

  Preference({

    required this.name,
    required this.imageUrl,
    this.selected = false,
  });

  factory Preference.fromJson(Map<String, dynamic> json) {
    return Preference(
      name: json['name'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      selected: json['selected'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'selected': selected,
    };
  }
} */