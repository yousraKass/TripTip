// my_preferences_page with bloc
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triptip/views/themes/colors.dart';
import 'package:triptip/views/themes/style.dart';
import 'package:triptip/views/themes/fonts.dart';
import 'package:triptip/views/widgets/Preference_widget.dart';
import 'package:triptip/blocs/client/preferences_cubit.dart';
import 'package:triptip/blocs/client/preferences_state.dart';
import 'package:triptip/data/repositories/client/preferences_repository.dart';

class MyPreferencesPage extends StatelessWidget {
  static const pageRoute = "client_preferences_page";

  final String clientId; // Add clientId as a required parameter
  late final PreferencesRepository prefRepository = PreferencesRepository();
  late final PreferencesCubit prefCubit;

  MyPreferencesPage({Key? key, required this.clientId}) : super(key: key) {
    prefCubit = PreferencesCubit(prefRepository, clientId)..loadPreferences();
  } 
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => prefCubit,
      child: const PreferencesView(),
    );
  }
}

class PreferencesView extends StatelessWidget {
  const PreferencesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _buildAppBar(),
      body: const PreferencesBody(),
      bottomNavigationBar: const PreferencesBottomBar(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      title: Text(
        'My preferences',
        style: navbarTitle,
      ),
      centerTitle: true,
    );
  }
}

class PreferencesBody extends StatelessWidget {
  const PreferencesBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "I am interested in: ",
            style: TextStyle(fontFamily: FontFamily.medium, fontSize: 18),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: BlocBuilder<PreferencesCubit, PreferencesState>(
              builder: (context, state) {
                return switch (state) {
                  PreferencesLoading() => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  PreferencesError() => Center(
                      child: Text("Error: ${state.message}"),
                    ),
                  PreferencesLoaded() => PreferencesGrid(
                      preferences: state.preferences,
                    ),
                  _ => const Center(
                      child: Text("No interests available."),
                    ),
                };
              },
            ),
          ),
        ],
      ),
    );
  }
}

/* class PreferencesGrid extends StatelessWidget {
  final List preferences;

  const PreferencesGrid({
    Key? key,
    required this.preferences,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.85,
      ),
      itemCount: preferences.length,
      itemBuilder: (context, index) {
        final preference = preferences[index];
        return GestureDetector(
          onTap: () {
            context.read<PreferencesCubit>().togglePreference(preference);
          },
          child: PreferenceCell(context, preference, "preferences"),
        );
      },
    );
  }
}
 */

class PreferencesGrid extends StatelessWidget {
  final List preferences;

  const PreferencesGrid({
    Key? key,
    required this.preferences,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.85,
      ),
      itemCount: preferences.length,
      itemBuilder: (context, index) {
        final preference = preferences[index];
        return GestureDetector(
          onTap: () {
            context.read<PreferencesCubit>().togglePreference(index);
          },
          child: PreferenceCell(
            context,
            preference,
            preference.selected ? "selected" : "not_selected",
          ),
        );
      },
    );
  }
}
class PreferencesBottomBar extends StatelessWidget {
  const PreferencesBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: AppColors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              foregroundColor: AppColors.main,
            ),
            child: const Text("Skip"),
          ),
          ElevatedButton(
            onPressed: () {
              // Save preferences and navigate back
              context.read<PreferencesCubit>().savePreferences();
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.main,
            ),
            child: Text(
              "Save",
              style: TextStyle(color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }
}