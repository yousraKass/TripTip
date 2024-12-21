class Preference {
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
}