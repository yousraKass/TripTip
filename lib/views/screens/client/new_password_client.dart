import 'package:flutter/material.dart';
import 'package:triptip/views/themes/style.dart';
import 'package:triptip/views/themes/colors.dart';
import 'package:triptip/views/widgets/logos.dart';
import 'package:triptip/views/widgets/Password_form_field.dart';
import 'package:triptip/views/screens/client/login_page_client.dart';
import 'package:triptip/blocs/client/forgot_password_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triptip/data/repositories/client/client_repo.dart';

class NewPasswordClient extends StatelessWidget {
  NewPasswordClient({super.key});

  static const pageRoute = "/new_password_client_page";

  final TextEditingController emailController = TextEditingController();
  final TextEditingController txt_controller_psd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordCubit(
        repository: ClientRepository(),
      ),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          leading: back_btn(context),
          backgroundColor: AppColors.white,
        ),
        body: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
          listener: (context, state) {
            if (state is PasswordUpdated) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Password updated successfully!')),
              );
              Navigator.pushNamed(context, LoginPageClient.pageRoute);
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
                        Text("Create New Password", style: mainTitle),
                        SizedBox(height: 20),
                        Text(
                          "Keep your account secure by creating a new password",
                          style: subTitle,
                        ),
                        SizedBox(height: 50),
                        Form(
                          key: state.formKey,
                          child: Column(
                            children: [
                              PasswordFormField(
                                  txtControllerPsd: txt_controller_psd),
                              SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () {
                                  if (context
                                      .read<ForgotPasswordCubit>()
                                      .validateForm()) {
                                    context
                                        .read<ForgotPasswordCubit>()
                                        .updatePassword(
                                          emailController.text,
                                          txt_controller_psd.text,
                                        );
                                  }
                                },
                                child: Text(
                                  "Save new password",
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
/* 
class NewPasswordClient extends StatefulWidget {
  const NewPasswordClient({super.key});

  static const pageRoute = "/new_password_client_page";

  @override
  State<NewPasswordClient> createState() => _NewPasswordClientState();
}

class _NewPasswordClientState extends State<NewPasswordClient> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController txt_controller_psd = TextEditingController();


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
                      "Create New Password",
                      style: mainTitle,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Keep your account secure by creating a new password",
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
                          PasswordFormField(txtControllerPsd: txt_controller_psd),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                Navigator.pushNamed(context, LoginPageClient.pageRoute);  
                              }
                            },
                            child: Text(
                              "Save new password",
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
