/* // agency_model
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
} */
// agency_model
class AgencyModel {
  final String? profilePictureAgency;
  final String? name; //agencyTitle
  final String email;
  final String password;
  final String? phoneNumber; //phoneNumber,
  final int? location; //agencyAddress,
  final String? aboutUs;
  
  AgencyModel({
    this.profilePictureAgency,
    this.name,
    required this.email,
    required this.password,
    this.phoneNumber,
    this.location,
    this.aboutUs,
  });

  factory AgencyModel.fromJson(Map<String, dynamic> json) {
    return AgencyModel(
      profilePictureAgency : json['profilePictureAgency'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      phoneNumber: json['phone_number'],
      location: json['location'],
      aboutUs: json['aboutUs'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'profilePictureAgency': profilePictureAgency,
      'name': name,
      'email': email,
      'password': password,
      'phone_number': phoneNumber,
      'location': location,
      'aboutUs': aboutUs,
    };
  }
}
