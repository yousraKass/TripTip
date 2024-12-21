import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triptip/bloc/repositories/client_repo.dart';
import 'package:triptip/bloc/models/client_model.dart';
import 'package:triptip/bloc/states/client_profile_state.dart';
import 'package:triptip/bloc/repositories/preferences_repository.dart';
import 'package:image_picker/image_picker.dart';


class ClientProfileCubit extends Cubit<ClientProfileState> {
  final ClientRepository repository;
  final PreferencesRepository preferencesRepository;  

  final ImagePicker _picker = ImagePicker();
  ClientProfileCubit(this.repository)
      : preferencesRepository = PreferencesRepository(),  
        super(ClientProfileLoading());

  void loadClientProfile() async {
    try {
      emit(ClientProfileLoading());
      
      // Fetch both profile and preferences
      final profile = await repository.fetchClientProfile();
      final preferences = await preferencesRepository.getUserPreferences();
      
      emit(ClientProfileLoaded(profile, preferences));
    } catch (e) {
      emit(ClientProfileError(e.toString()));
    }
  }

  void updateClientProfile(ClientModel profile) async {
    try {
      await repository.updateClientProfile(profile);
      emit(ClientProfileUpdated(profile));
    } catch (e) {
      emit(ClientProfileError(e.toString()));
    }
  }

  Future<void> pickImage() async {
    if (state is! ClientProfileLoaded) return;
    
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        final currentState = state as ClientProfileLoaded;
        final updatedProfile = ClientModel(
          imagePath: pickedFile.path,  // Store the path
        );

        // Update the profile with new image path
        await repository.updateClientProfile(updatedProfile);
        emit(ClientProfileLoaded(updatedProfile, currentState.preferences));
      }
    } catch (e) {
      emit(ClientProfileError('Error picking image: $e'));
    }
  }

}
