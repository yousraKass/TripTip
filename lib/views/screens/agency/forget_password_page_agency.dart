import 'package:flutter/material.dart';
import 'package:triptip/views/themes/style.dart';
import 'package:triptip/views/themes/colors.dart';
import 'package:triptip/views/widgets/logos.dart';
import 'package:triptip/logic/form_validators.dart';
import 'package:triptip/views/widgets/Forms_widgets.dart';
import 'package:triptip/blocs/agency/forgot_password_cubit_agency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triptip/data/repositories/agency/agency_repo.dart';
import 'package:triptip/views/screens/agency/new_password_agency.dart';
/* 
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
 */



class ForgetPasswordAgency extends StatelessWidget {
  ForgetPasswordAgency({super.key});
  
  static const pageRoute = "/agency_forget_password_page";

  final TextEditingController emailController = TextEditingController();
  final TextEditingController txt_controller_psd = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordCubit(
        repository: AgencyRepository(),
      ),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          leading: back_btn(context),
          backgroundColor: AppColors.white,
        ),
        body: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
          listener: (context, state) {
            if (state is ResetCodeSent) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Reset code sent to your email!')),
              );
              Navigator.pushNamed(context, NewPasswordAgency.pageRoute);
            } else if (state is ForgotPasswordError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  trip2(context),
                  Padding(
                    padding: pdn,
                    child: Column(
                      children: [
                        Text("Forget Password", style: mainTitle),
                        SizedBox(height: 20),
                        Text(
                          "Enter your email address below, we will send you an email to reset your password",
                          style: subTitle,
                        ),
                        SizedBox(height: 50),
                        Form(
                          key: state.formKey,
                          child: Column(
                            children: [
                              UserInput(
                                context,
                                "Enter your email",
                                validateEmail,
                                emailController,
                              ),
                              SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () {
                                  if (context.read<ForgotPasswordCubit>().validateForm()) {
                                    context.read<ForgotPasswordCubit>().sendResetCode(emailController.text);
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
            );
          },
        ),
      ),
    );
  }
}