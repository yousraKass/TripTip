import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triptip/bloc/choose_user.dart';
import 'package:triptip/bloc/blocs/choice_bloc.dart';
import 'package:triptip/bloc/blocs/password_visibility_bloc.dart';
import 'package:triptip/bloc/login_page_agency.dart';
import 'package:triptip/bloc/login_page_client.dart';
import 'package:triptip/bloc/signup_page_agency.dart';
import 'package:triptip/bloc/signup_page_client.dart';


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
          LoginScreenClient.pageRoute: (context) => LoginScreenClient(),
          SignupScreen.pageRoute: (context) => SignupScreen(),
          LoginScreen.pageRoute: (context) => LoginScreen(),
        },
      ),
    );
  }
}
