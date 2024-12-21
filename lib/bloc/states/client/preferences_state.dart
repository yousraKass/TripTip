
import 'package:triptip/bloc/models/client/preferences_model.dart';
abstract class PreferencesState {}

class PreferencesInitial extends PreferencesState {}

class PreferencesLoading extends PreferencesState {}

class PreferencesLoaded extends PreferencesState {
  final List<Preference> preferences;
  
  PreferencesLoaded(this.preferences);
}

class PreferencesError extends PreferencesState {
  final String message;
  
  PreferencesError(this.message);
}
class PreferenceUpdated extends  PreferencesState{
  final  Preference updatedPreference;

  PreferenceUpdated(this.updatedPreference);
}

