import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triptip/blocs/client/preferences_state.dart';
import 'package:triptip/data/repositories/client/preferences_repository.dart';
import 'package:triptip/data/models/client/preferences_model.dart';


class PreferencesCubit extends Cubit<PreferencesState> {
  final PreferencesRepository _repository;
  final int clientId;

  PreferencesCubit(this._repository, this.clientId) : super(PreferencesInitial());

  Future<void> loadPreferences() async {
    try {
      emit(PreferencesLoading());
      final preferences = await _repository.getUserPreferences(clientId);
      emit(PreferencesLoaded(preferences));
    } catch (e) {
      emit(PreferencesError(e.toString()));
    }
  }

  Future<void> savePreferences() async {
    final currentState = state;
    if (currentState is PreferencesLoaded) {
      try {
        // Collect IDs of selected preferences
        final selectedPreferenceIds = currentState.preferences
            .where((preference) => preference.selected)
            .map((preference) => preference.id)
            .toList();

        // Send the list of selected preference IDs to the backend
        await _repository.updateUserPreferences(selectedPreferenceIds);
      } catch (e) {
        emit(PreferencesError(e.toString()));
      }
    }
  }

  void togglePreference(Preference preference) async {
    final currentState = state;
    if (currentState is PreferencesLoaded) {
      final updatedPreferences = List<Preference>.from(currentState.preferences);
      final index = updatedPreferences.indexWhere((p) => p.id == preference.id);
      if (index != -1) {
        updatedPreferences[index].selected = !updatedPreferences[index].selected;
        emit(PreferencesLoaded(updatedPreferences));
      }
    }
  }
}



