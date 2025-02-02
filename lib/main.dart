import 'package:flutter/material.dart';
import 'package:triptip/views/screens/agency/login_page_agency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triptip/views/screens/client/login_page_client.dart';
import 'package:triptip/views/screens/agency/signup_agency.dart';
import 'package:triptip/views/screens/client/signup_client.dart';
import 'package:triptip/data/repo/preferences/AbstractPreferences.dart';
import 'package:triptip/data/repo/preferences/DummyPreferences.dart';
import 'package:triptip/data/repo/notification_agency/AbstractNotificationAgency.dart';
import 'package:triptip/data/repo/notification_agency/DummyNotificationAgency.dart';
import 'package:triptip/views/screens/shared/landing_page.dart';
import 'package:triptip/views/screens/shared/SignUpAsScreen.dart';
import 'blocs/Offer_bloc/offer_cubit.dart';
import 'data/repositories/OfferRepo.dart';

import 'package:triptip/blocs/shared/choice_bloc.dart';
import 'package:triptip/blocs/shared/password_visibility_bloc.dart';

late AbstractPreferenes preferences;
late Abstractnotificationagency notifications;

Future<bool> my_init_app() async {
  preferences = Dummypreferences();
  notifications = Dummynotificationagency();
  return true;
}

// void main() async {
//   await my_init_app();
//   runApp(const MainApp());
// }

// class MainApp extends StatelessWidget {
//   const MainApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       initialRoute: LandingPage.pageRoute,
//       routes: {
//         FavoritePage.pageRoute: (ctx) => FavoritePage(),
//         SignUpChoicePage.pageRoute : (ctx) => SignUpChoicePage(),
//         LoginPageAgency.pageRoute: (ctx) => LoginPageAgency(),
//         LoginPageClient.pageRoute: (ctx) => LoginPageClient(),
//         ForgetPasswordAgency.pageRoute: (ctx) => ForgetPasswordAgency(),
//         ForgetPasswordClient.pageRoute: (ctx) => ForgetPasswordClient(),
//         NewPasswordClient.pageRoute: (ctx) => NewPasswordClient(),
//         NewPasswordAgency.pageRoute: (ctx) => NewPasswordAgency(),
//         SignUpAgency.pageRoute: (ctx) => SignUpAgency(),
//         SignUpClient.pageRoute: (ctx) => SignUpClient(),
//         MyPreferencesPage.pageRoute: (ctx) => MyPreferencesPage(),
//         NotificationsAgency.pageRoute: (ctx) => NotificationsAgency(),
//         NotificationsClient.pageRoute: (ctx) => NotificationsClient(),
//         ClientProfile.pageRoute: (ctx) => ClientProfile(),
//         EditClientProfileScreen.pageRoute: (ctx) => EditClientProfileScreen(),
//         OfferDetailsPage.pageRoute: (ctx) => const OfferDetailsPage(),
//         ReviewScreenAgency.pageRoute: (ctx) => const ReviewScreenAgency(),
//         ReviewScreenClient.pageRoute: (ctx) => const ReviewScreenClient(),
//         AgencyScreen.pageRoute: (ctx) => const AgencyScreen(),
//         EditAgencyProfileScreen.pageRoute: (ctx) =>
//         const EditAgencyProfileScreen(),
//         SettingsScreenClient.pageRoute: (ctx) => const SettingsScreenClient(),
//         SettingsScreenAgency.pageRoute: (ctx) => const SettingsScreenAgency(),
//         Intro01.pageRoute: (ctx) => const Intro01(),
//         Intro02.pageRoute: (ctx) => const Intro02(),
//         Intro03.pageRoute: (ctx) => const Intro03(),
//         LandingPage.pageRoute: (ctx) => const LandingPage(),
//         SearchPage.pageRoute: (ctx) => const SearchPage(),
//         FilterPage.pageRoute: (ctx) => const FilterPage(),
//         ResultsPage.pageRoute: (ctx) => const ResultsPage(),
//         OffersPage.pageRoute: (ctx) => const OffersPage(),
//         OffersPageAgency.pageRoute: (ctx) => const OffersPageAgency(),
//         AddOfferPage.pageRoute: (ctx) => const AddOfferPage(),
//       },
//     );
//   }
// }

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(
//           create: (context) => OfferCubit(
//             offerRepo: OfferRepo(),
//           ),
//         ),
//         // Add other BlocProviders here if needed
//       ],
//       child: MaterialApp(
//         title: 'Your App Name',
//         theme: ThemeData(
//             // Your theme configuration
//             ),
//         home: const LandingPage(),
//         // Your route configuration
//       ),
//     );
//   }
// }

void main() {
  runApp(const TripTipApp());
}

class TripTipApp extends StatelessWidget {
  const TripTipApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ChoiceBloc>(
          create: (context) => ChoiceBloc(),
        ),
        BlocProvider<PasswordVisibilityBloc>(
          create: (context) => PasswordVisibilityBloc(),
        ),
        BlocProvider(
          create: (context) => OfferCubit(
            offerRepo: OfferRepo(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'TripTip App',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        initialRoute: SignUpChoicePage.pageRoute,
        routes: {
          SignUpChoicePage.pageRoute: (context) => const SignUpChoicePage(),
          SignUpClient.pageRoute: (context) => SignUpClient(),
          LoginPageClient.pageRoute: (context) => LoginPageClient(),
          SignUpAgency.pageRoute: (context) => SignUpAgency(),
          LoginPageAgency.pageRoute: (context) => LoginPageAgency(),
          LandingPage.pageRoute: (context) => const LandingPage(),
        },
      ),
    );
  }
}

