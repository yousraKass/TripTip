import 'package:flutter/material.dart';
import 'package:triptip/views/themes/colors.dart';
import 'package:triptip/views/themes/style.dart';
import 'package:triptip/views/widgets/Preferences_image_slider.dart';
import 'package:triptip/views/widgets/ClientrProfileHeader.dart';
import 'package:triptip/views/screens/client/preferences.dart';
import 'package:triptip/main.dart';
import 'package:triptip/views/widgets/BottomNavigationBar.dart';

class ClientProfile extends StatefulWidget {
  const ClientProfile({super.key});

  static const pageRoute = "/client_profile";

  @override
  State<ClientProfile> createState() => _ClientProfileState();
}

class _ClientProfileState extends State<ClientProfile> {
  late Future<List> client_preferences;
  
  @override
  Widget build(BuildContext context) {
    client_preferences = preferences.GetUserPreferences();
    return Scaffold(
      backgroundColor: AppColors.white,
      bottomNavigationBar: BottomNavigationBarExample(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header Section
              buildHeader(context, {"image": "assets/images/agencypfp.png", "title": "Kassous Yousra"}), 
              
              //     Positioned(
              //       top: 10,
              //       left: 10,
              //       child: trip3(context),
              //     ),
            

              const SizedBox(height: 40),

              Padding(
                padding: const EdgeInsets.only(left: 30, top: 10, bottom: 10),
                child: Column(
                  children: [                    
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
              const SizedBox(height: 50),

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
                    Navigator.pushNamed(
                        context, MyPreferencesPage.pageRoute);
                  }),
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
