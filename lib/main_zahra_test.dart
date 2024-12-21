import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triptip/views/screens/shared/SignUpAsScreen.dart';
import 'package:triptip/bloc/shared/choice_bloc.dart';
import 'package:triptip/bloc/shared/password_visibility_bloc.dart';
import 'package:triptip/views/screens/agency/login_page_agency.dart';
import 'package:triptip/views/screens/client/login_page_client.dart';
import 'package:triptip/views/screens/agency/signup_agency.dart';
import 'package:triptip/views/screens/client/signup_client.dart';

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
        },
      ),
    );
  }
}
