import '../OfferModel.dart';

// agency_model
class AgencyModel {
  final int id;
  final String? backGroundAgency;
  final String? profilePictureAgency;
  final String? name; //agencyTitle
  final String email;
  final String password;
  final String? phoneNumber; //phoneNumber,
  final String? location; //agencyAddress,
  final String? aboutUs;
  final List<OfferModel> offers;
  final String? instagram;
  final String? facebook;
  final String? link;

  AgencyModel(
      {this.id = 0,
      this.backGroundAgency,
      this.profilePictureAgency,
      this.name,
      required this.email,
      required this.password,
      this.phoneNumber,
      this.location,
      this.aboutUs,
      this.instagram,
      this.facebook,
      this.link,
      required this.offers});

  factory AgencyModel.fromJson(Map<String, dynamic> json) {
    return AgencyModel(
      id: json['id'],
      backGroundAgency: json['cover_photo'],
      profilePictureAgency: json['profile_photo'],
      name: json['agency_name'],
      email: json['email'],
      password: json['agency_password'],
      phoneNumber: json['phone_number'],
      location: json['agency_location'],
      aboutUs: json['agency_description'],
      instagram: json['instagram'],
      facebook: json['facebook'],
      link: json['website_link'],
      offers: json['offers']
          .map<OfferModel>((offer) => OfferModel.fromJson(offer))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'backGroundAgency': backGroundAgency,
      'profilePictureAgency': profilePictureAgency,
      'agency_name': name,
      'email': email,
      'password': password,
      'phone_number': phoneNumber,
      'location': location,
      'agency_description': aboutUs,
      'instagram': instagram,
      'facebook': facebook,
      'link': link,
      'offers': offers.map((offer) => offer.toJson()).toList(),
    };
  }
}
