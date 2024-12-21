import 'package:flutter/material.dart';
import 'package:triptip/views/screens/client/login_page_client.dart';
import 'package:triptip/views/themes/style.dart';
import 'package:triptip/views/widgets/logos.dart';
import 'package:triptip/logic/form_validators.dart';
import 'package:triptip/views/widgets/Forms_widgets.dart';
import 'package:triptip/views/themes/colors.dart';
import 'package:triptip/views/widgets/Password_form_field.dart';


class SignUpClient extends StatefulWidget {
  const SignUpClient({super.key});

  static const pageRoute = "/client_signup_page";

  @override
  State<SignUpClient> createState() => _SignUpClientState();
}

class _SignUpClientState extends State<SignUpClient> {
  // form key
  final _formKey = GlobalKey<FormState>();
  String? selectedCountryCode;
  bool isChecked = false;

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
                      "Create account",
                      style: mainTitle,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Get the best out of TripTip by creating an account",
                      style: subTitle,
                    ),
                    SizedBox(height: 30),
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // firstname
                          InputLabel("Firstname"),
                          UserInput(context, "Enter your first name",
                              validateName, null),

                          SizedBox(height: 20),

                          // lastname
                          InputLabel("Lastname"),
                          UserInput(context, "Enter your last name",
                              validateName, null),

                          SizedBox(height: 20),

                          // birthdate
                          InputLabel("birthdate"),
                          UserInput(context, "mm/dd/yyyy",
                              validateDate, null),

                          SizedBox(height: 20),

                          
                          // email
                          InputLabel("Email"),
                          UserInput(context, "Enter your email",
                              validateEmail, null),

                          SizedBox(height: 20),

                        
                          // password
                          InputLabel("Password"),
                          PasswordFormField(txtControllerPsd: txt_controller_psd),

                          SizedBox(height: 20),
                          Row(
                            children: [
                              // Checkbox
                              Checkbox(
                                value: isChecked,
                                onChanged: (value) {},
                              ),

                              // Text with underlined terms and conditions
                              GestureDetector(
                                onTap: () {
                                  // Optional: Handle the click event
                                  print("Terms and conditions clicked");
                                },
                                child: RichText(
                                  text: TextSpan(
                                    text: 'I accept ',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16.0),
                                    children: [
                                      TextSpan(
                                        text: 'terms and conditions',
                                        style: TextStyle(
                                          color: AppColors.main,
                                          decoration: TextDecoration
                                              .underline, // Underline the text
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                Navigator.pushNamed(
                                    context, LoginPageClient.pageRoute);
                              }
                            },
                            child: Text(
                              "Create account",
                              style: accounts_button_text_style,
                            ),
                            style: accounts_button_style(context),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: dont_have_account,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, LoginPageClient.pageRoute);
                          },
                          child: Text(
                            'Log In ',
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
