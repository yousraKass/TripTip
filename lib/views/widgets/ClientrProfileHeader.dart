import 'package:flutter/material.dart';
import 'package:triptip/views/screens/agency/EditAgencyProfile.dart';
import 'package:triptip/views/screens/client/SettingsScreenClient.dart';
import 'package:triptip/views/screens/client/notifications_client.dart';
import 'package:triptip/views/screens/client/edit_client_profile.dart';
import 'package:triptip/views/themes/colors.dart';
import 'package:triptip/views/themes/fonts.dart';

Widget buildHeader(BuildContext context, Map<String, dynamic> agencyData) {
  return Stack(
    children: [
      Stack(
        children: [
          // Shadow effect
          ClipPath(
            clipper: HeaderClipper(),
            child: Container(
              height: 253, // Slightly larger for shadow placement
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.grey.withOpacity(0.5), // Shadow color
                    Colors.transparent, // Fade out the shadow
                  ],
                ),
              ),
            ),
          ),

          // Background Image
          ClipPath(
            clipper: HeaderClipper(),
            child: Container(
              height: 250,
              decoration: BoxDecoration(
                color: AppColors.main,
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 30,
                    right: 20,
                    child: IconButton(
                      icon: Container(
                        padding: const EdgeInsets.all(3),
                        child: SizedBox(
                          height: 28,
                          width: 28,
                          child: Image.asset(
                            'assets/icons/settings.png',
                            color: AppColors.black,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(
                            context, SettingsScreenClient.pageRoute);
                      },
                    ),
                  ),
                  Positioned(
                    top: 30,
                    right: 65,
                    child: IconButton(
                      icon: const Icon(Icons.notifications, size: 35),
                      onPressed: () {
                        Navigator.pushNamed(
                            context, NotificationsClient.pageRoute);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // Logo and Title
      Positioned(
        top: 170,
        left: 60,
        //right: 20,
        child: Column(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage(
                agencyData["image"],
              ),
              backgroundColor: Colors.white,
            ),
          ],
        ),
      ),
      buildTitle(context, agencyData),
    ],
  );
}

Widget buildTitle(BuildContext context, Map<String, dynamic> agencyData) {
  return Padding(
      padding: const EdgeInsets.fromLTRB(60, 290, 0, 0),
      child: Column(
        children: [
          Row(
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                agencyData["title"],
                style: const TextStyle(
                  color: AppColors.black,
                  fontFamily: FontFamily.medium,
                  fontSize: 27,
                  //fontWeight: FontWeight.,
                ),
              ),
              const SizedBox(width: 10),
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
                        context, EditClientProfileScreen.pageRoute);
                  }),
            ],
          ),
        ],
      ));
}
