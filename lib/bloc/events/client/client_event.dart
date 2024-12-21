abstract class ClientEvent {}

class ClientLoginSubmitted extends ClientEvent {
  final String email;
  final String password;

  ClientLoginSubmitted({
    required this.email,
    required this.password,
  });
}
class ClientSignupSubmitted extends ClientEvent {
  final String firstname;
  final String lastname;
  final String birthdate;
  final String email;
  final String password;
  final int wilaya;

  ClientSignupSubmitted({
    required  this.firstname,
    required  this.lastname,
    required  this.birthdate,
    required this.email,
    required this.password,
    required this.wilaya,
  });
}
