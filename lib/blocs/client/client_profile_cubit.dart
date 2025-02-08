import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triptip/data/imageUpload/imageUpload.dart';
import 'package:triptip/data/repositories/client/client_repo.dart';
import 'package:triptip/data/models/client/client_model.dart';
import 'package:triptip/blocs/client/client_state.dart';
import 'package:triptip/data/repositories/client/preferences_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:developer'; // For logging

import 'package:supabase_flutter/supabase_flutter.dart';


class ClientProfileCubit extends Cubit<ClientState> {
  final ClientRepository repository;
  final ImagePicker _picker = ImagePicker();
  final int clientId;

  ClientProfileCubit({
    required this.repository,
    required this.clientId,
  }) : super(ClientProfileLoading());

  void loadClientProfile() async {
    try {
      emit(ClientProfileLoading());
      print("Fetching profile..."); // Debug log
      final profile = await repository.fetchClientProfile(clientId);
      print("Profile fetched: $profile"); // Debug log

      // Preferences are now part of the profile response
      emit(ClientProfileLoaded(profile, profile.preferences ?? []));
    } catch (e) {
      print("Error loading profile: $e"); // Debug log
      emit(ClientProfileError(e.toString()));
    }
  }

  void updateClientProfile(ClientModel profile) async {
    try {
      emit(ClientProfileLoading()); // Show loading state
      await repository.updateClientProfile(profile);

      // Fetch updated profile (including preferences)
      final updatedProfile = await repository.fetchClientProfile(clientId);
      emit(ClientProfileLoaded(updatedProfile, updatedProfile.preferences ?? []));
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
        emit(ClientProfileLoaded(updatedProfile, updatedProfile.preferences ?? []));
      }
    } catch (e) {
      log('Error picking image: $e'); // Log the error
      emit(ClientProfileError('Error picking image: $e'));
    }
  }
}