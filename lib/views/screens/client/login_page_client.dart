import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triptip/bloc/client/client_event.dart';
import 'package:triptip/data/repositories/client/client_repo.dart';
import 'package:triptip/views/themes/style.dart';
import 'package:triptip/views/widgets/Forms_widgets.dart';
import 'package:triptip/views/widgets/Password_form_field.dart';
import 'package:triptip/views/widgets/logos.dart';
import 'package:triptip/views/screens/agency/forget_password_page_agency.dart';
import 'package:triptip/logic/form_validators.dart';
import 'package:triptip/views/screens/client/signup_client.dart';
import 'package:triptip/bloc/client/client_state.dart';
import 'package:triptip/bloc/client/client_bloc.dart';



class LoginPageClient extends StatelessWidget {
   static const pageRoute = "/LoginPageClient";
    late final clientRepository = ClientRepository();
    late final loginBloc = ClientBloc(repository: clientRepository);
  // Controllers for form inputs
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: BlocProvider(
          create: (context) => loginBloc,
          child: BlocConsumer<ClientBloc, ClientState>(
            listener: (context, state) {
              if (state is ClientSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Login Successful!')),
                );
                Navigator.pushReplacementNamed(context, '/home');
              } else if (state is ClientFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)),
                );
              }
            },
            builder: (context, state) {
              if (state is ClientLoading) {
                return Center(child: CircularProgressIndicator());
              }

              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  trip2(context), // Custom Logo/Header
                  Padding(
                    padding: pdn,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Welcome to TripTip", style: mainTitle),
                        SizedBox(height: 10),
                        Text("Please log in to your account", style: subTitle),
                        SizedBox(height: 20),

                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Email Input
                              InputLabel("Email"),
                              UserInput(context, "Enter your email address",
                                  validateEmail, emailController),
                              SizedBox(height: 10),

                              // Password Input
                              InputLabel("Password"),
                              PasswordFormField(
                                  txtControllerPsd: passwordController),

                              // Forgot Password
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context,
                                        ForgetPasswordAgency.pageRoute);
                                  },
                                  child: Text(
                                    "Forgot password?",
                                    style: forget_password,
                                  ),
                                ),
                              ),

                              SizedBox(height: 10),

                              // Login Button
                              ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    final email = emailController.text;
                                    final password = passwordController.text;

                                    BlocProvider.of<ClientBloc>(context).add(
                                      ClientLoginSubmitted(
                                          email: email, password: password),
                                    );
                                  }
                                },
                                style: accounts_button_style(context),
                                child: Text(
                                  "Login",
                                  style: accounts_button_text_style,
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 30),

                        // Login with Options
                        LoginInWith(),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Facebook Login
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Implement Facebook Login
                                },
                                style: LoginInWith_button_style(context),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.facebook,
                                        color: const Color(0xFF1C65F1)),
                                    SizedBox(width: 10),
                                    Text(
                                      "Facebook",
                                      style: LoginInWith_button_text_style,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 20),

                            // Gmail Login
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Implement Gmail Login
                                },
                                style: LoginInWith_button_style(context),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.email, color: Colors.red),
                                    SizedBox(width: 10),
                                    Text(
                                      "Gmail",
                                      style: LoginInWith_button_text_style,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 20),

                        // Sign Up Prompt
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account on TripTip?",
                                style: dont_have_account),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, SignUpClient.pageRoute);
                              },
                              child:
                                  Text('Create account', style: create_account),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
