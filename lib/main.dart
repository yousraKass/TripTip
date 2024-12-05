import 'package:flutter/material.dart';
import 'views/screens/OfferScreen.dart';
import 'views/screens/agencyProfile.dart';
import 'views/screens/ReviewScreen.dart';
import 'views/screens/EditAgencyProfile.dart';
import 'views/screens/SettingsScreen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return   MaterialApp(
       initialRoute: OfferDetailsPage.pageRoute,
       routes: {
        OfferDetailsPage.pageRoute : (ctx) => const OfferDetailsPage(),
        ReviewScreen.pageRoute : (ctx) => const ReviewScreen(),
        AgencyScreen.pageRoute : (ctx) => const AgencyScreen(),
        EditAgencyProfileScreen.pageRoute : (ctx) => const EditAgencyProfileScreen(),
         SettingsScreen.pageRoute : (ctx) => const SettingsScreen(),

      },
     
    );
  }
}
