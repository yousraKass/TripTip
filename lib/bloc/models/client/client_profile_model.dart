class ClientProfileModel {
  final String firstName;
   final String lastName;
  final String email;
  final String location;
  final String birthDate;
  final String imagePath;

  ClientProfileModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.location,
    required this.birthDate,
    required this.imagePath,

  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'location': location,
      'birthDate': birthDate,
      'imagePath': imagePath,
    };
  }

  factory ClientProfileModel.fromJson(Map<String, dynamic> json) {
    return ClientProfileModel(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      location: json['location'],
      birthDate: json['birthDate'],
      imagePath: json['imagePath'],
    );
  }
}
