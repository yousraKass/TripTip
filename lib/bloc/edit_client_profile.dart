import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triptip/logic/form_validators.dart';
import 'package:triptip/views/themes/colors.dart';
import 'package:triptip/views/themes/style.dart';
import 'package:triptip/views/widgets/logos.dart';
import 'package:triptip/views/widgets/BottomNaviagtionBarClient.dart';
import 'package:triptip/bloc/blocs/client_profile_cubit.dart';
import 'package:triptip/bloc/states/client_profile_state.dart';
import 'package:triptip/bloc/models/client_model.dart';
import 'dart:io';

class EditClientProfileScreen extends StatelessWidget {
  EditClientProfileScreen({Key? key}) : super(key: key);
  
  static const pageRoute = "/edit_client_profile";

 
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final wilayaController = TextEditingController();

  void _updateControllers(ClientModel profile) {
    firstNameController.text = profile.getFirstname ?? 'first name not provided';
    lastNameController.text = profile.getLastname ?? 'last name not provided';
    emailController.text = profile.getEmail ?? 'email not provided';
    dateOfBirthController.text = profile.getBirthdate ?? 'birthdate not provided';
    wilayaController.text = profile.getWilayaName ?? 'wilaya not provided';
  }

  @override
  Widget build(BuildContext context) {
    // Load profile data when the widget is first built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ClientProfileCubit>().loadClientProfile();
    });

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text('Edit Profile', style: navbarTitle),
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        leading: back_btn(context),
      ),
      bottomNavigationBar: BottomNavigationBarExampleClient(),
      body: BlocConsumer<ClientProfileCubit, ClientProfileState>(
        listener: (context, state) {
          if (state is ClientProfileUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Profile updated successfully!')),
            );
            Navigator.pop(context);
          } else if (state is ClientProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.errorMessage}')),
            );
          } else if (state is ClientProfileLoaded) {
            _updateControllers(state.profile);
          }
        },
        builder: (context, state) {
          if (state is ClientProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildProfilePicture(context, state),
                const SizedBox(height: 20),
                _buildForm(context, state),
                const SizedBox(height: 80),
                _buildSaveButton(context, state),
              ],
            ),
          );
        },
      ),
    );
  }

 Widget _buildProfilePicture(BuildContext context, ClientProfileState state) {
    final String imagePath = state is ClientProfileLoaded 
        ? state.profile.getImagePath ?? 'IMG not provided' 
        : '';
    
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: imagePath.isNotEmpty
                ? FileImage(File(imagePath)) as ImageProvider
                : const AssetImage('assets/images/profile_picture.png'),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: IconButton(
              icon: const Icon(Icons.camera_alt, size: 25, color: Colors.blue),
              onPressed: () => context.read<ClientProfileCubit>().pickImage(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm(BuildContext context, ClientProfileState state) {
    return Column(
      children: [
        TextFormField(
          controller: firstNameController,
          decoration: edit_profile_fields("First Name"),
        ),
        const SizedBox(height: 10),

        TextFormField(
          controller: lastNameController,
          decoration: edit_profile_fields("Last Name"),
        ),
        const SizedBox(height: 10),

        TextFormField(
          controller: emailController,
          decoration: edit_profile_fields("email"),
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 10),

        TextFormField(
          controller: dateOfBirthController,
          decoration: edit_profile_fields("Date of Birth"),
          keyboardType: TextInputType.datetime,
        ),
        const SizedBox(height: 10),

        TextFormField(
          controller: wilayaController,
          decoration: edit_profile_fields("wilaya"),
        ),
      ],
    );
  }

  Widget _buildSaveButton(BuildContext context, ClientProfileState state) {
    return ElevatedButton(
      onPressed: () {
        final updatedProfile = ClientModel(
          firstname: firstNameController.text,
          lastname: lastNameController.text,
          email: emailController.text,
          birthdate: dateOfBirthController.text,
          wilayaID:TransferNametoNumber(wilayaController.text),
          imagePath: (state is ClientProfileLoaded && state.profile.getImagePath != null)
              ? state.profile.getImagePath
              : 'assets/images/profile_picture.png',
        );
        context.read<ClientProfileCubit>().updateClientProfile(updatedProfile);
      },
      child: Text('Save', style: accounts_button_text_style),
      style: Save_changes_style(context),
    );
  }
}