import '../../data/models/OfferModel.dart';

abstract class AgencyEvent {}


class FetchPublicAgencyById extends AgencyEvent {
  final int agencyId;
  
  FetchPublicAgencyById(this.agencyId);
}
// Login Event
class AgencyLoginSubmitted extends AgencyEvent {
  final String email;
  final String password;

  AgencyLoginSubmitted({required this.email, required this.password});
}

// Signup Event
class AgencySignupSubmitted extends AgencyEvent {
  final String name;
  final String email;
  final String password;
  final String phoneNumber;
  final String location;
  final String? aboutUs;
  final List<OfferModel>? offers;

  AgencySignupSubmitted({
    required this.name,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.location,
    this.aboutUs,
    this.offers,
  });
}

class AgencyEditProfileSubmitted extends AgencyEvent {
  final String name;
  final String email;
  final String password;
  final String phoneNumber;
  final String location;
  final String? aboutUs;
  final List<OfferModel>? offers;
  final String? token;

  AgencyEditProfileSubmitted({
    required this.name,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.location,
    this.aboutUs,
    this.offers,
    this.token,
  });
}

class FetchAgencyById extends AgencyEvent {
  final int agencyId;
  final String token;
  
  FetchAgencyById(this.agencyId, this.token);
}

