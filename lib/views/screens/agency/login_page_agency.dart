import 'package:flutter/material.dart';
import 'package:triptip/views/screens/agency/agencyProfile.dart';
import 'package:triptip/views/screens/agency/forget_password_page_agency.dart';
import 'package:triptip/views/screens/agency/signup_agency.dart';
import 'package:triptip/views/themes/style.dart';
import 'package:triptip/views/widgets/logos.dart';
import 'package:triptip/logic/form_validators.dart';
import 'package:triptip/views/widgets/Forms_widgets.dart';
import 'package:triptip/views/widgets/Password_form_field.dart';


class LoginPageAgency extends StatefulWidget {
  const LoginPageAgency({super.key});

  static const pageRoute = "/agency_login_page";

  @override
  State<LoginPageAgency> createState() => _LoginPageAgencyState();
}

class _LoginPageAgencyState extends State<LoginPageAgency> {
  // form key
  final _formKey = GlobalKey<FormState>();

  final TextEditingController txt_controller_email = TextEditingController();
  final TextEditingController txt_controller_psd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      home: Scaffold(
        appBar: AppBar(
          leading: back_btn(context),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              trip2(context),
              Padding(
                padding: pdn,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome to TripTip",
                      style: mainTitle,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Please choose your login option below",
                      style: subTitle,
                    ),
                    SizedBox(height: 10),
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // email
                          InputLabel("Email"),
                          UserInput(context, "Enter your email address",
                              validateEmail, txt_controller_email),

                          SizedBox(height: 10),

                          // password
                          InputLabel("Password"),
                          PasswordFormField(
                              txtControllerPsd: txt_controller_psd),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, ForgetPasswordAgency.pageRoute);
                                },
                                child: Text(
                                  "Forgot password?",
                                  style: forget_password,
                                )),
                          ),

                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                Navigator.pushNamed(context, AgencyScreen.pageRoute);
                              }                              
                            },
                            child: Text(
                              "Login",
                              style: accounts_button_text_style,
                            ),
                            style: accounts_button_style(context),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    LoginInWith(),
                    SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Center(
                            child: ElevatedButton(
                              onPressed: () {
                                // implement login with facebook
                              },
                              style: LoginInWith_button_style(context),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                        ),
                        SizedBox(width: 20),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Center(
                            child: ElevatedButton(
                              onPressed: () {
                                // implement login with gmail
                              },
                              style: LoginInWith_button_style(context),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.email,
                                    color: Colors.red,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "Gmail",
                                    style: LoginInWith_button_text_style,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account on TripTip?",
                          style: dont_have_account,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, SignUpAgency.pageRoute);
                          },
                          child: Text(
                            'Create account',
                            style: create_account,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
