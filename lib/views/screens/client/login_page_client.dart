import 'package:flutter/material.dart';
import 'package:triptip/views/screens/agency/forget_password_page.dart';
import 'package:triptip/views/themes/style.dart';
import 'package:triptip/views/widgets/logos.dart';
import 'package:triptip/logic/form_validators.dart';
import 'package:triptip/views/widgets/Forms_widgets.dart';

class LoginPageClient extends StatefulWidget {
  const LoginPageClient({super.key});

  static const pageRoute = "/agency_login_page";

  @override
  State<LoginPageClient> createState() => _LoginPageClientState();
}

class _LoginPageClientState extends State<LoginPageClient> {
  // form key
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  final TextEditingController txt_controller_email = TextEditingController();
  final TextEditingController txt_controller_psd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              trip2(context),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome to TripTip",
                      style: mainTitle,
                    ),
                    Box,
                    Text(
                      "Please choose your login option below",
                      style: subTitle,
                    ),
                    Box,
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // email
                              InputLabel("Email"),
                              UserInput(context, "Enter your email address",
                                  validateEmail, txt_controller_email),

                              Box,

                              // password
                              InputLabel("Password"),
                              Center(
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: TextFormField(
                                    obscureText: _obscureText,
                                    decoration: InputDecoration(
                                      hintText: "Enter your password",
                                      hintStyle: field_hint,
                                      border: OutlineInputBorder(),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _obscureText
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _obscureText = !_obscureText;
                                          });
                                        },
                                      ),
                                    ),
                                    controller: txt_controller_psd,
                                    validator: (value) {
                                      return validatePassword(value);
                                    },
                                  ),
                                ),
                              ),

                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, ForgetPassword.pageRoute);
                                    },
                                    child: Text(
                                      "Forgot password?",
                                      style: forget_password,
                                    )),
                              ),

                              ElevatedButton(
                                onPressed: () {},
                                child: Text(
                                  "Login",
                                  style: accounts_button_text_style,
                                ),
                                style: accounts_button_style(context),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Box,
                    Box,
                    Box,
                    LoginInWith(),
                    Box,
                    Box,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Center(
                            child: ElevatedButton(
                              onPressed: () {},
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
                              onPressed: () {},
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
                    Box,
                    Box,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account on TripTip?",
                          style: dont_have_account,
                        ),
                        TextButton(
                          onPressed: () {},
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
