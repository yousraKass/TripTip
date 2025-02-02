import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triptip/data/repositories/client/client_repo.dart';
import 'package:triptip/data/models/client/client_model.dart';
import 'package:triptip/blocs/client/client_state.dart';
import 'package:triptip/data/repositories/client/preferences_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:developer'; // For logging

/* 
class ClientProfileCubit extends Cubit<ClientState> {
  final ClientRepository repository;
  final PreferencesRepository preferencesRepository;  
  final ImagePicker _picker = ImagePicker();

  ClientProfileCubit({
    required this.repository,
    required this.preferencesRepository,
  }) : super(ClientProfileLoading());

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
      emit(ClientProfileLoading()); // Show loading state
      await repository.updateClientProfile(profile);

      // Fetch updated preferences
      final preferences = await preferencesRepository.getUserPreferences();
      emit(ClientProfileLoaded(profile, preferences));
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
        
        // Merge the new image path with the existing profile data
        final updatedProfile = currentState.profile.copyWith(
          imagePath: pickedFile.path,
        );

        // Update the profile with the new image path
        await repository.updateClientProfile(updatedProfile);
        
        // Emit the updated state with the new profile and existing preferences
        emit(ClientProfileLoaded(updatedProfile, currentState.preferences));
      }
    } catch (e) {
      log('Error picking image: $e'); // Log the error
      emit(ClientProfileError('Error picking image: $e'));
    }
  }
}
 */
class ClientProfileCubit extends Cubit<ClientState> {
  final ClientRepository repository;
  final PreferencesRepository preferencesRepository;  
  final ImagePicker _picker = ImagePicker();
  final String clientId; // Add clientId as a field

  ClientProfileCubit({
    required this.repository,
    required this.preferencesRepository,
    required this.clientId, // Add clientId as a required parameter
  }) : super(ClientProfileLoading());

  void loadClientProfile() async {
    try {
      emit(ClientProfileLoading());
      
      // Fetch both profile and preferences
      final profile = await repository.fetchClientProfile(clientId); // Pass clientId
      final preferences = await preferencesRepository.getUserPreferences(clientId); // Pass clientId
      
      emit(ClientProfileLoaded(profile, preferences));
    } catch (e) {
      emit(ClientProfileError(e.toString()));
    }
  }

  void updateClientProfile(ClientModel profile) async {
    try {
      emit(ClientProfileLoading()); // Show loading state
      await repository.updateClientProfile(profile);

      // Fetch updated preferences
      final preferences = await preferencesRepository.getUserPreferences(clientId); // Pass clientId
      emit(ClientProfileLoaded(profile, preferences));
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
        
        // Merge the new image path with the existing profile data
        final updatedProfile = currentState.profile.copyWith(
          imagePath: pickedFile.path,
        );

        // Update the profile with the new image path
        await repository.updateClientProfile(updatedProfile);
        
        // Emit the updated state with the new profile and existing preferences
        emit(ClientProfileLoaded(updatedProfile, currentState.preferences));
      }
    } catch (e) {
      log('Error picking image: $e'); // Log the error
      emit(ClientProfileError('Error picking image: $e'));
    }
  }
}

/* import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triptip/data/repositories/client/client_repo.dart';
import 'package:triptip/data/models/client/client_model.dart';
import 'package:triptip/blocs/client/client_state.dart';
import 'package:triptip/data/repositories/client/preferences_repository.dart';
import 'package:image_picker/image_picker.dart';


class ClientProfileCubit extends Cubit<ClientState> {
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
 */