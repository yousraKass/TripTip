import '../OfferModel.dart';
// agency_model
class AgencyModel {
  final String? profilePictureAgency;
  final String? name; //agencyTitle
  final String email;
  final String password;
  final String? phoneNumber; //phoneNumber,
  final int? location; //agencyAddress,
  final String? aboutUs;
  final List<OfferModel> offers;

  
  AgencyModel({
    this.profilePictureAgency,
    this.name,
    required this.email,
    required this.password,
    this.phoneNumber,
    this.location,
    this.aboutUs,
    required this.offers
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
      offers: json['offers'].map<OfferModel>((offer) => OfferModel.fromJson(offer)).toList(),
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
      'offers': offers.map((offer) => offer.toJson()).toList(),
    };
  }
}






