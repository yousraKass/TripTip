import 'package:triptip/data/models/client/client_model.dart';
import 'package:triptip/data/models/client/preferences_model.dart';

abstract class ClientState {}

// Initial state
class ClientInitial extends ClientState {}

// Loading states
class ClientLoading extends ClientState {} // For authentication

class ClientProfileLoading extends ClientState {} // For profile loading

// Success states
class ClientSuccess extends ClientState {
  // For authentication
  final ClientModel client;
  ClientSuccess({required this.client});
}

class ClientProfileLoaded extends ClientState {
  // For profile loaded
  final ClientModel profile;
  final List<Preference> preferences;
  ClientProfileLoaded(this.profile, this.preferences);
}

class ClientProfileUpdated extends ClientState {
  // For profile updated
  final ClientModel updatedProfile;
  ClientProfileUpdated(this.updatedProfile);
}

// Error states
class ClientFailure extends ClientState {
  // For authentication
  final String error;
  ClientFailure({required this.error});
}

class ClientProfileError extends ClientState {
  // For profile errors
  final String errorMessage;
  ClientProfileError(this.errorMessage);
}
