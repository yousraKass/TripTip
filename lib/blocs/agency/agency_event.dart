import '../OfferModel.dart';
abstract class AgencyEvent {}

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
  final int location;
  final String aboutUs;
  final List offers;

  AgencySignupSubmitted({
    required this.name,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.location,
  });
}
