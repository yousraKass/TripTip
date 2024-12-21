// agency_model
class AgencyModel {
  final String? name;
  final String email;
  final String password;
  final String? phoneNumber;
  final int? location;

  AgencyModel({
     this.name,
    required this.email,
    required this.password,
     this.phoneNumber,
     this.location,
  });

  factory AgencyModel.fromJson(Map<String, dynamic> json) {
    return AgencyModel(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      phoneNumber: json['phone_number'],
      location: json['location'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'phone_number': phoneNumber,
      'location': location,
    };
  }
}