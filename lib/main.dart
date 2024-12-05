import 'package:flutter/material.dart';
import 'package:triptip/views/screens/agency/login_page_agency.dart';
import 'package:triptip/views/screens/agency/forget_password_page.dart';
import 'package:triptip/views/screens/agency/new_password_agency.dart';
import 'package:triptip/views/screens/agency/signup_agency.dart';
import 'package:triptip/views/screens/agency/notifications_agency.dart';
import 'package:triptip/views/screens/client/notifications_client.dart';
import 'package:triptip/views/screens/client/signup_client.dart';
import 'package:triptip/views/screens/client/client_profile.dart';
import 'package:triptip/views/screens/client/edit_client_profile.dart';
import 'package:triptip/views/screens/client/preferences.dart';
import 'package:triptip/data/repo/preferences/AbstractPreferences.dart';
import 'package:triptip/data/repo/preferences/DummyPreferences.dart';
import 'package:triptip/data/repo/notification_agency/AbstractNotificationAgency.dart';
import 'package:triptip/data/repo/notification_agency/DummyNotificationAgency.dart';
import 'package:triptip/views/screens/agency/agencyProfile.dart';
import 'package:triptip/views/screens/agency/EditAgencyProfile.dart';
import 'package:triptip/views/screens/agency/ReviewScreenAgency.dart';
import 'package:triptip/views/screens/agency/SettingsScreenAgency.dart';
import 'package:triptip/views/screens/client/ReviewScreenClient.dart';
import 'package:triptip/views/screens/client/SettingsScreenClient.dart';
import 'package:triptip/views/screens/shared/OfferScreen.dart';
import 'package:triptip/views/screens/shared/intro01.dart';
import 'package:triptip/views/screens/shared/intro02.dart';
import 'package:triptip/views/screens/shared/intro03.dart';
import 'package:triptip/views/screens/shared/landing_page.dart';
import 'package:triptip/views/screens/shared/search_page.dart';





late AbstractPreferenes preferences;
late Abstractnotificationagency notifications;

Future<bool> my_init_app() async {
  preferences = Dummypreferences();
  notifications = Dummynotificationagency();
  return true;
}

void main() async{
  await my_init_app();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Intro01.pageRoute ,
      routes: {
        LoginPageAgency.pageRoute: (ctx) => LoginPageAgency(),
        ForgetPassword.pageRoute: (ctx) => ForgetPassword(),
        NewPassword.pageRoute: (ctx) => NewPassword(),
        SignUpAgency.pageRoute: (ctx) => SignUpAgency(),
        SignUpClient.pageRoute: (ctx) => SignUpClient(),
        MyPreferencesPage.pageRoute: (ctx) => MyPreferencesPage(),
        NotificationsAgency.pageRoute: (ctx) =>NotificationsAgency(),
        NotificationsClient.pageRoute: (ctx) =>NotificationsClient(),
        ClientProfile.pageRoute: (ctx) =>ClientProfile(),
        EditClientProfileScreen.pageRoute: (ctx) =>EditClientProfileScreen(),
        OfferDetailsPage.pageRoute : (ctx) => const OfferDetailsPage(),
        ReviewScreenAgency.pageRoute : (ctx) => const ReviewScreenAgency(),
        ReviewScreenClient.pageRoute : (ctx) => const ReviewScreenClient(),
        AgencyScreen.pageRoute : (ctx) => const AgencyScreen(),
        EditAgencyProfileScreen.pageRoute : (ctx) => const EditAgencyProfileScreen(),
        SettingsScreenClient.pageRoute : (ctx) => const SettingsScreenClient(),
        SettingsScreenAgency.pageRoute : (ctx) => const SettingsScreenAgency(),
        Intro01.pageRoute : (ctx) => const Intro01(),
        Intro02.pageRoute : (ctx) => const Intro02(),                             
        Intro03.pageRoute : (ctx) => const Intro03(), 
        LandingPage.pageRoute : (ctx) => const LandingPage(),
        SearchPage.pageRoute : (ctx) => const SearchPage(),
        
      

      },
    );
  }
}