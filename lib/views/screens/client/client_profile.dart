import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triptip/views/themes/colors.dart';
import 'package:triptip/views/themes/style.dart';
import 'package:triptip/views/widgets/Preferences_image_slider.dart';
import 'package:triptip/views/widgets/ClientrProfileHeader.dart';
import 'package:triptip/blocs/client/client_profile_cubit.dart';
import 'package:triptip/blocs/client/client_state.dart';
import 'package:triptip/views/screens/client/preferences.dart';
import 'package:triptip/data/repositories/client/client_repo.dart';
import 'package:triptip/data/repositories/client/preferences_repository.dart';
import 'package:triptip/data/models/client/preferences_model.dart';
import 'package:triptip/data/imageUpload/imageUpload.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ClientProfile extends StatelessWidget {
  static const pageRoute = "/ClientProfile";
  final int clientId;

  /* ClientProfile({required this.clientId}); */
  const ClientProfile({Key? key, required this.clientId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: BlocProvider(
          create: (context) => ClientProfileCubit(
            repository: ClientRepository(),
            clientId: clientId,
          )..loadClientProfile(),
          child: BlocBuilder<ClientProfileCubit, ClientState>(
            builder: (context, state) {
              if (state is ClientProfileLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ClientProfileError) {
                return Center(child: Text('Error: ${state.errorMessage}'));
              } else if (state is ClientProfileLoaded) {
                final profile = state.profile;
                final preferences = state.preferences;

                return Column(
                  children: [
                    // Header Section
                    buildHeader(context, {
                      "image": profile.imagePath,
                      "title": profile.fullName,
                    }),
                    const SizedBox(height: 40),

                    // User Info Section
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 30, top: 10, bottom: 10),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          _buildInfoRow(
                            icon: Icons.email,
                            text: profile.getEmail ?? 'No email provided',
                          ),
                          const SizedBox(height: 20),
                          _buildInfoRow(
                            icon: Icons.location_on,
                            text: profile.getWilayaName ?? 'No wilaya',
                          ),
                          const SizedBox(height: 20),
                          _buildInfoRow(
                            icon: Icons.calendar_today,
                            text: profile.getBirthdate ?? 'No birthdate',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50),

                    // Preferences Section
                    _buildPreferencesSection(context, preferences),
                  ],
                );
              } else {
                return const Center(child: Text('Unknown state'));
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow({required IconData icon, required String text}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(icon),
        const SizedBox(width: 10),
        Text(text, style: user_info_style),
      ],
    );
  }

  Widget _buildPreferencesSection(
      BuildContext context, List<Preference> preferences) {
    // Filter preferences to show only selected ones
    final selectedPreferences =
        preferences.where((pref) => pref.selected).toList();

    // Convert Preference objects to maps
    final preferenceMaps = selectedPreferences
        .map((pref) => pref.toJson()) // Use toJson() to convert to Map
        .toList();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "My preferences:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            IconButton(
              icon: SizedBox(
                height: 20,
                width: 20,
                child: Image.asset(
                  'assets/icons/editer.png',
                  height: 30,
                  width: 30,
                  color: AppColors.black,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyPreferencesPage(clientId: clientId),
                  ),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 20),
        selectedPreferences.isEmpty
            ? const Text('No preferences found')
            : MyCarousel(data: preferenceMaps), // Pass the list of maps
      ],
    );
  }
}
