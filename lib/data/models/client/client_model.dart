/* class ClientModel {
  final String? id; 
  final String? firstname;
  final String? lastname;
  final String? email;
  final String? password; 
  final String? birthdate;
  final int? wilayaID; 
  final String? wilayaName;
  final Wilaya? wilaya; 
  final String? imagePath; 

  ClientModel({
    this.id,
    this.firstname,
    this.lastname,
    this.email,
    this.password,
    this.birthdate,
    this.wilayaID,
    this.wilayaName,
    this.wilaya,
    this.imagePath,
  });

  // Getters for the properties
  String? get getFirstname => firstname;
  String? get getLastname => lastname;
  String? get getEmail => email;
  String? get getPassword => password;
  String? get getBirthdate => birthdate;
  int? get getWilayaID => wilayaID;
  String? get getWilayaName => wilayaName;
  String? get getImagePath => imagePath;

  // Custom getter for full name
  String get fullName => '${firstname ?? ''} ${lastname ?? ''}';

  // Convert ClientModel to JSON for login/sign-up
  Map<String, dynamic> toJsonForAuth() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'password': password,
      'birthdate': birthdate,
      'wilayaID': wilayaID,
      'wilayaName': wilayaName,
    };
  }

  // Convert ClientModel to JSON for profile update
  Map<String, dynamic> toJsonForEditInfo() {
    return {
      'name': firstname,
      'surname': lastname,
      'birthdate': birthdate,
      'email': email,
      'wilaya': wilaya?.id,
      'profile_photo': imagePath,
    };
  }

  // Factory method to parse JSON for profile
  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      id: json['id'],
      firstname: json['name'] ?? json['firstname'], // Handle both "name" and "firstname"
      lastname: json['surname'] ?? json['lastname'], // Handle both "surname" and "lastname"
      email: json['email'],
      birthdate: json['birthdate'],
      wilaya: json['wilaya'] != null ? Wilaya.fromJson(json['wilaya']) : null,
      imagePath: json['profile_photo'] ?? json['imagePath'], // Handle both "profile_photo" and "imagePath"
    );
  }
}

// Wilaya model to handle the nested "wilaya" object
class Wilaya {
  final int? id;
  final String? name;

  Wilaya({
     this.id,
     this.name,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory Wilaya.fromJson(Map<String, dynamic> json) {
    return Wilaya(
      id: json['id'],
      name: json['name'],
    );
  }
} */
class ClientModel {
  final String? id;
  final String? firstname;
  final String? lastname;
  final String? email;
  final String? password;
  final String? birthdate;
  final int? wilayaID;
  final String? wilayaName;
  final Wilaya? wilaya;
  final String? imagePath;

  ClientModel({
    this.id,
    this.firstname,
    this.lastname,
    this.email,
    this.password,
    this.birthdate,
    this.wilayaID,
    this.wilayaName,
    this.wilaya,
    this.imagePath,
  });

  // Getters for the properties
  String? get getFirstname => firstname;
  String? get getLastname => lastname;
  String? get getEmail => email;
  String? get getPassword => password;
  String? get getBirthdate => birthdate;
  int? get getWilayaID => wilayaID;
  String? get getWilayaName => wilayaName;
  String? get getImagePath => imagePath;

  // Custom getter for full name
  String get fullName => '${firstname ?? ''} ${lastname ?? ''}';

  // Convert ClientModel to JSON for login/sign-up
  Map<String, dynamic> toJsonForAuth() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'password': password,
      'birthdate': birthdate,
      'wilayaID': wilayaID,
      'wilayaName': wilayaName,
    };
  }

  // Convert ClientModel to JSON for profile update
  Map<String, dynamic> toJsonForEditInfo() {
    return {
      'name': firstname,
      'surname': lastname,
      'birthdate': birthdate,
      'email': email,
      'wilaya': wilaya?.id,
      'profile_photo': imagePath,
    };
  }

  // Factory method to parse JSON for profile
  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      id: json['id'],
      firstname: json['name'] ??
          json['firstname'], // Handle both "name" and "firstname"
      lastname: json['surname'] ??
          json['lastname'], // Handle both "surname" and "lastname"
      email: json['email'],
      birthdate: json['birthdate'],
      wilaya: json['wilaya'] != null ? Wilaya.fromJson(json['wilaya']) : null,
      imagePath: json['profile_photo'] ??
          json['imagePath'], // Handle both "profile_photo" and "imagePath"
    );
  }

  // Add copyWith method
  ClientModel copyWith({
    String? id,
    String? firstname,
    String? lastname,
    String? email,
    String? password,
    String? birthdate,
    int? wilayaID,
    String? wilayaName,
    Wilaya? wilaya,
    String? imagePath,
  }) {
    return ClientModel(
      id: id ?? this.id,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      password: password ?? this.password,
      birthdate: birthdate ?? this.birthdate,
      wilayaID: wilayaID ?? this.wilayaID,
      wilayaName: wilayaName ?? this.wilayaName,
      wilaya: wilaya ?? this.wilaya,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}

// Wilaya model to handle the nested "wilaya" object
class Wilaya {
  final int? id;
  final String? name;

  Wilaya({
    this.id,
    this.name,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory Wilaya.fromJson(Map<String, dynamic> json) {
    return Wilaya(
      id: json['id'],
      name: json['name'],
    );
  }
}
