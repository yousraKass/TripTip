import 'package:flutter/material.dart';
import 'package:triptip/views/themes/style.dart';
import 'package:triptip/views/themes/colors.dart';
import 'package:triptip/views/widgets/logos.dart';
import 'package:triptip/logic/form_validators.dart';
import 'package:triptip/views/widgets/Forms_widgets.dart';
import 'package:triptip/views/screens/shared/landing_page.dart';

class ForgetPasswordAgency extends StatefulWidget {
  const ForgetPasswordAgency({super.key});

  static const pageRoute = "/agency_forget_password_page";

  @override
  State<ForgetPasswordAgency> createState() => _ForgetPasswordAgencyState();
}

class _ForgetPasswordAgencyState extends State<ForgetPasswordAgency> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          leading: back_btn(context),
          backgroundColor: AppColors.white,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              trip2(context),
              Padding(
                padding: pdn,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Forget Password",
                      style: mainTitle,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Enter your email address below , we will send you an email to reset your password",
                      style: subTitle,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          UserInput(
                              context, "Enter your email", validateEmail, null),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                Navigator.pushNamed(
                                    context, LandingPage.pageRoute);
                              }
                            },
                            child: Text(
                              "Request code",
                              style: accounts_button_text_style,
                            ),
                            style: accounts_button_style(context),
                          ),
                        ],
                      ),
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
