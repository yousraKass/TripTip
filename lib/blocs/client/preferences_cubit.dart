import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triptip/blocs/client/preferences_state.dart';
import 'package:triptip/data/repositories/client/preferences_repository.dart';
import 'package:triptip/data/models/client/preferences_model.dart';


class PreferencesCubit extends Cubit<PreferencesState> {
  final PreferencesRepository _repository;

  PreferencesCubit(this._repository) : super(PreferencesInitial());

  Future<void> loadPreferences() async {
    try {
      emit(PreferencesLoading());
      final preferences = await _repository.getUserPreferences();
      emit(PreferencesLoaded(preferences));
    } catch (e) {
      emit(PreferencesError(e.toString()));
    }
  }

  void togglePreference(int index) async {
    final currentState = state;
    if (currentState is PreferencesLoaded) {
      final updatedPreferences = List<Preference>.from(currentState.preferences);
      final preference = updatedPreferences[index];
      preference.selected = !preference.selected;
      emit(PreferencesLoaded(updatedPreferences));
      try {
        await _repository.updateUserPreference(preference);
      } catch (e) {
        emit(PreferencesError(e.toString()));
      }
    }
  }
}

