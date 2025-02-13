import 'package:flutter/material.dart';
import 'package:triptip/views/screens/agency/login_page_agency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triptip/views/screens/agency/forget_password_page_agency.dart';
import 'package:triptip/views/screens/client/agencyScreenClientView.dart';
import 'package:triptip/views/screens/client/forget_password_page_client.dart';
import 'package:triptip/views/screens/agency/new_password_agency.dart';
import 'package:triptip/views/screens/client/login_page_client.dart';
import 'package:triptip/views/screens/client/new_password_client.dart';
import 'package:triptip/views/screens/agency/signup_agency.dart';
import 'package:triptip/views/screens/agency/notifications_agency.dart';
import 'package:triptip/views/screens/client/notifications_client.dart';
import 'package:triptip/views/screens/client/signup_client.dart';
import 'package:triptip/views/screens/client/client_profile.dart';
import 'package:triptip/views/screens/client/edit_client_profile.dart';
import 'package:triptip/data/repo/preferences/AbstractPreferences.dart';
import 'package:triptip/data/repo/preferences/DummyPreferences.dart';
import 'package:triptip/data/repo/notification_agency/AbstractNotificationAgency.dart';
import 'package:triptip/data/repo/notification_agency/DummyNotificationAgency.dart';
import 'package:triptip/views/screens/agency/agencyProfile.dart';
import 'package:triptip/views/screens/agency/EditAgencyProfile.dart';
import 'package:triptip/views/screens/agency/SettingsScreenAgency.dart';
import 'package:triptip/views/screens/client/SettingsScreenClient.dart';
import 'package:triptip/views/screens/shared/OfferScreen.dart';
import 'package:triptip/views/screens/shared/intro01.dart';
import 'package:triptip/views/screens/shared/intro02.dart';
import 'package:triptip/views/screens/shared/intro03.dart';
import 'package:triptip/views/screens/shared/landing_page.dart';
import 'package:triptip/views/screens/shared/search_page.dart';
import 'package:triptip/views/screens/shared/filter_page.dart';
import 'package:triptip/views/screens/shared/results_page.dart';
import 'package:triptip/views/screens/shared/offers_page.dart';
import 'package:triptip/views/screens/agency/offers_page_agency.dart';
import 'package:triptip/views/screens/agency/add_offer.dart';
import 'package:triptip/views/screens/shared/SignUpAsScreen.dart';
import 'blocs/Offer_bloc/offer_cubit.dart';
import 'data/repositories/OfferRepo.dart';
import 'package:triptip/blocs/shared/choice_bloc.dart';
import 'package:triptip/blocs/shared/password_visibility_bloc.dart';
import 'package:triptip/blocs/agency/agency_bloc.dart';
import 'package:triptip/data/repositories/agency/agency_repo.dart';
import 'package:triptip/data/repositories/search_repository.dart';
import 'package:triptip/blocs/Search/search_cubit.dart';

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
// FavoritePage.pageRoute: (ctx) => FavoritePage(),
// SignUpChoicePage.pageRoute : (ctx) => SignUpChoicePage(),
// LoginPageAgency.pageRoute: (ctx) => LoginPageAgency(),
// LoginPageClient.pageRoute: (ctx) => LoginPageClient(),
// ForgetPasswordAgency.pageRoute: (ctx) => ForgetPasswordAgency(),
// ForgetPasswordClient.pageRoute: (ctx) => ForgetPasswordClient(),
// NewPasswordClient.pageRoute: (ctx) => NewPasswordClient(),
// NewPasswordAgency.pageRoute: (ctx) => NewPasswordAgency(),
// SignUpAgency.pageRoute: (ctx) => SignUpAgency(),
// SignUpClient.pageRoute: (ctx) => SignUpClient(),
// MyPreferencesPage.pageRoute: (ctx) => MyPreferencesPage(),
// NotificationsAgency.pageRoute: (ctx) => NotificationsAgency(),
// NotificationsClient.pageRoute: (ctx) => NotificationsClient(),
// ClientProfile.pageRoute: (ctx) => ClientProfile(),
// EditClientProfileScreen.pageRoute: (ctx) => EditClientProfileScreen(),
// ReviewScreenAgency.pageRoute: (ctx) => const ReviewScreenAgency(),
// ReviewScreenClient.pageRoute: (ctx) => const ReviewScreenClient(),
// SettingsScreenClient.pageRoute: (ctx) => const SettingsScreenClient(),
// SettingsScreenAgency.pageRoute: (ctx) => const SettingsScreenAgency(),
// Intro01.pageRoute: (ctx) => const Intro01(),
// Intro02.pageRoute: (ctx) => const Intro02(),
// Intro03.pageRoute: (ctx) => const Intro03(),
// LandingPage.pageRoute: (ctx) => const LandingPage(),
// SearchPage.pageRoute: (ctx) => const SearchPage(),
// FilterPage.pageRoute: (ctx) => const FilterPage(),
// ResultsPage.pageRoute: (ctx) => const ResultsPage(),
// OffersPage.pageRoute: (ctx) => const OffersPage(),
// OffersPageAgency.pageRoute: (ctx) => const OffersPageAgency(),
// AddOfferPage.pageRoute: (ctx) => const AddOfferPage(),
//       },
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
        BlocProvider<AgencyBloc>(
          create: (context) => AgencyBloc(repository: AgencyRepository()),
        ),
        BlocProvider<PasswordVisibilityBloc>(
          create: (context) => PasswordVisibilityBloc(),
        ),
        BlocProvider(
          create: (context) => OfferCubit(
            offerRepo: OfferRepo(),
          ),
        ),
        BlocProvider(
          create: (context) => SearchCubit(
            repository: SearchRepository(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'TripTip App',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        initialRoute: LandingPage.pageRoute,
        routes: {
          OffersPageAgency.pageRoute: (ctx) => const OffersPageAgency(),
          FilterPage.pageRoute: (ctx) => const FilterPage(),
          ResultsPage.pageRoute: (ctx) => const ResultsPage(),
          SearchPage.pageRoute: (ctx) => const SearchPage(),
          AgencyScreenClientView.pageRoute: (ctx) => AgencyScreenClientView(),
          AgencyScreen.pageRoute: (ctx) => const AgencyScreen(),
          EditAgencyProfileScreen.pageRoute: (ctx) => EditAgencyProfileScreen(),
          SignUpChoicePage.pageRoute: (context) => const SignUpChoicePage(),
          SignUpClient.pageRoute: (context) => SignUpClient(),
          LoginPageClient.pageRoute: (context) => LoginPageClient(),
          SignUpAgency.pageRoute: (context) => SignUpAgency(),
          LoginPageAgency.pageRoute: (context) => LoginPageAgency(),
          LandingPage.pageRoute: (context) => const LandingPage(),
          OfferDetailsPage.pageRoute: (ctx) => const OfferDetailsPage(
                offerId: 1,
              ),
          ClientProfile.pageRoute: (context) {
            final args = ModalRoute.of(context)!.settings.arguments as int;
            return ClientProfile(clientId: args);
          },
          NotificationsClient.pageRoute: (ctx) => NotificationsClient(),
          NotificationsAgency.pageRoute: (ctx) => NotificationsAgency(),
          EditClientProfileScreen.pageRoute: (ctx) => EditClientProfileScreen(),
          SettingsScreenClient.pageRoute: (ctx) => const SettingsScreenClient(),
          SettingsScreenAgency.pageRoute: (ctx) => const SettingsScreenAgency(),
          Intro01.pageRoute: (ctx) => const Intro01(),
          Intro02.pageRoute: (ctx) => const Intro02(),
          Intro03.pageRoute: (ctx) => const Intro03(),
          OffersPage.pageRoute: (ctx) => const OffersPage(),
          NewPasswordClient.pageRoute: (ctx) => NewPasswordClient(),
          NewPasswordAgency.pageRoute: (ctx) => NewPasswordAgency(),
          ForgetPasswordAgency.pageRoute: (ctx) => ForgetPasswordAgency(),
          ForgetPasswordClient.pageRoute: (ctx) => ForgetPasswordClient(),
         
        },
      ),
    );
  }
}
