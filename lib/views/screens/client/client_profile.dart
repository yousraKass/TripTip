import 'package:flutter/material.dart';
import 'package:triptip/views/themes/colors.dart';
import 'package:triptip/views/themes/style.dart';
import 'package:triptip/views/widgets/Preferences_image_slider.dart';
import 'package:triptip/views/widgets/logos.dart';
import 'package:triptip/main.dart';

class ClientProfile extends StatefulWidget {
  const ClientProfile({super.key});

  static const pageRoute = "/client_profile";

  @override
  State<ClientProfile> createState() => _ClientProfileState();
}

class _ClientProfileState extends State<ClientProfile> {
  late Future<List> client_preferences;
  void _editProfileName() {
    // Logic to edit profile name
    print("Edit profile name clicked");
  }

  void _editPreferences() {
    // Logic to edit preferences
    print("Edit preferences clicked");
  }

  @override
  Widget build(BuildContext context) {
    client_preferences = preferences.GetUserPreferences();
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header Section
              Stack(
                children: [
                  Container(
                    height: 250,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.main, AppColors.white],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: trip3(context),
                  ),
                  Positioned(
                    top: 20,
                    right: 60,
                    child: IconButton(
                      icon: const Icon(Icons.notifications, size: 30),
                      onPressed: () {},
                    ),
                  ),
                  Positioned(
                    top: 20,
                    right: 10,
                    child: IconButton(
                      icon: const Icon(Icons.settings, size: 30),
                      onPressed: () {},
                    ),
                  ),

                  Positioned(
                    bottom: 40,
                    left: MediaQuery.of(context).size.width / 2 - 80,
                    child: CircleAvatar(
                      radius: 80,
                      backgroundImage: AssetImage('assets/images/golang.png'),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              Padding(
                padding: const EdgeInsets.only(left: 30, top: 10, bottom: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:const [
                        Icon(Icons.person),
                        SizedBox(width: 10),
                        Text("Kassous yousra", style: user_info_style),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Icon(Icons.email),
                        SizedBox(width: 10),
                        Text("kassousyousra@gmail.com", style: user_info_style),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Icon(Icons.location_on),
                        SizedBox(width: 10),
                        Text("Canberra ACT 2601, Australia", style: user_info_style),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Icon(Icons.calendar_today),
                        SizedBox(width: 10),
                        Text("03 décembre 2004", style: user_info_style),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Preferences Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      "My preferences:",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: _editPreferences,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              FutureBuilder<List>(
                future: client_preferences,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('No preferences found');
                  } else {
                    return MyCarousel(
                        data: snapshot.data as List<Map<String, dynamic>>);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
