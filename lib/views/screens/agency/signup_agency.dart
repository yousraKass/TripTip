import 'package:flutter/material.dart';
import 'package:triptip/views/screens/agency/login_page_agency.dart';
import 'package:triptip/views/themes/style.dart';
import 'package:triptip/views/widgets/logos.dart';
import 'package:triptip/logic/form_validators.dart';
import 'package:triptip/views/widgets/Forms_widgets.dart';
import 'package:triptip/views/themes/colors.dart';
import 'package:triptip/views/screens/shared/SignUpAsScreen.dart';

SignUpAs role = SignUpAs.Agency;




class SignUpAgency extends StatefulWidget {
  
  const SignUpAgency({super.key});

  static const pageRoute = "/agency_signup_page";
  
  @override
  State<SignUpAgency> createState() => _SignUpAgencyState();
}

class _SignUpAgencyState extends State<SignUpAgency> {
  // form key
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  String? selectedCountryCode;
  bool isChecked = false;
  List<String> countryCodes = ['+213', '+1', '+44', '+91'];

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
                      "Create agency's account",
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
                          // agency name
                          InputLabel("Agency's name"),
                          UserInput(context, "Enter agency name",
                              validateAgencyName, null),

                          SizedBox(height: 20),

                          // agency phone
                          InputLabel("Phone"),
                          UserInput(context, 'Enter phone number',
                              validatePhoneNumber, null),
                          SizedBox(
                            height: 20,
                          ),
                          // agency email
                          InputLabel("Agency email"),
                          UserInput(context, "Enter agency email",
                              validateEmail, null),

                          SizedBox(height: 20),

                          // agency location
                          InputLabel("Agency location"),
                          UserInput(context, "Enter agency location",
                              validateEmail, null),

                          SizedBox(height: 20),
                          // password
                          InputLabel("Password"),
                          Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: TextFormField(
                                obscureText: _obscureText,
                                decoration: InputDecoration(
                                  hintText: "Enter your password",
                                  hintStyle: field_hint,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade500,
                                      width: 0.5,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey
                                          .shade500, // Set the border color when the field is enabled
                                      width: 0.5,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors
                                          .main, // Set the border color when the field is focused
                                      width: 0.5,
                                    ),
                                  ),
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
                                    context, LoginPageAgency.pageRoute);
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
                            Navigator.pushNamed(context, LoginPageAgency.pageRoute);
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
