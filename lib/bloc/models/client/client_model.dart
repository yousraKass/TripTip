class ClientModel {
  final String? firstname;
  final String? lastname;
  final String? email;
  final String? password;
  final String? birthdate;
  final int? wilayaID;
  final String? wilayaName;
  final String? imagePath;

  ClientModel(
      {this.firstname,
      this.lastname,
      this.email,
      this.password,
      this.birthdate,
      this.wilayaID,
      this.wilayaName,
      this.imagePath});

  // Getters for the properties
  String? get getFirstname => firstname;
  String? get getLastname => lastname;
  String? get getEmail => email;
  String? get getPassword => password;
  String? get getBirthdate => birthdate;
  int? get getWilayaID => wilayaID;
  String? get getWilayaName => wilayaName;
  String? get getImagePath => imagePath;

  // You can also add custom getters if needed, e.g., for full name
  String get fullName => '${firstname ?? ''} ${lastname ?? ''}';

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      password: json['password'],
      birthdate: json['birthdate'],
      wilayaID: json['wilayaID'],
      wilayaName: json['wilayaName'],
      imagePath: json['imagePath'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'password': password,
      'birthdate': birthdate,
      'wilayaID': wilayaID,
      'wilayaName': wilayaName,
      'imagePath': imagePath,
    };
  }
}
