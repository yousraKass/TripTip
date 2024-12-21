import 'package:triptip/data/models/client/client_model.dart';
import 'package:triptip/data/models/client/preferences_model.dart';

abstract class ClientProfileState {}

class ClientProfileLoading extends ClientProfileState {}

class ClientProfileLoaded extends ClientProfileState {
  final ClientModel profile;
  final List<Preference> preferences;  // Added preferences

  ClientProfileLoaded(this.profile, this.preferences);  // Updated constructor
}

class ClientProfileError extends ClientProfileState {
  final String errorMessage;

  ClientProfileError(this.errorMessage);
}

class ClientProfileUpdated extends ClientProfileState {
  final ClientModel updatedProfile;
 
  ClientProfileUpdated(this.updatedProfile);  // Updated constructor
}