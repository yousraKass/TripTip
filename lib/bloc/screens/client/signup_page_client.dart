import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triptip/views/themes/style.dart';
import 'package:triptip/views/widgets/logos.dart';
import 'package:triptip/logic/form_validators.dart';
import 'package:triptip/views/widgets/Forms_widgets.dart';
import 'package:triptip/views/themes/colors.dart';
import 'package:triptip/views/widgets/Password_form_field.dart';
import 'package:triptip/bloc/blocs/client/client_bloc.dart'; // Import the SignupBloc
import 'package:triptip/bloc/screens/client/login_page_client.dart';
import 'package:triptip/bloc/states/client/client_state.dart';
import 'package:triptip/bloc/events/client/client_event.dart';
import 'package:triptip/bloc/repositories/client/client_repo.dart';

class SignUpClient extends StatelessWidget {

  SignUpClient({super.key});
  static const pageRoute = "/SignUpClient";
  late final clientRepository = ClientRepository();
  late final   signupBloc = ClientBloc(repository: clientRepository);
  // Controllers for form inputs
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController wilayaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    bool isChecked = false;

    return BlocProvider(
      create: (context) => signupBloc, 
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: pdn,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                trip2(context),
                SizedBox(height: 10),
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
                BlocConsumer<ClientBloc, ClientState>(
                  listener: (context, state) {
                    if (state is ClientSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Account created successfully!')),
                      );
                      Navigator.pushNamed(context, LoginScreenClient.pageRoute);
                    } else if (state is ClientFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.error)),
                      );
                    }
                  },
                  builder: (context, state) {
                    return Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InputLabel("Firstname"),
                          UserInput(context, "Enter your first name",
                              validateName, firstnameController),
                          SizedBox(height: 20),
                          InputLabel("Lastname"),
                          UserInput(context, "Enter your last name",
                              validateName, lastnameController),
                          SizedBox(height: 20),
                          InputLabel("Birthdate"),
                          UserInput(context, "mm/dd/yyyy", validateDate,
                              birthdateController),
                          SizedBox(height: 20),
                          InputLabel("Email"),
                          UserInput(context, "Enter your email", validateEmail,
                              emailController),
                          SizedBox(height: 20),
                           // agency location
                          InputLabel("Client location"),
                          UserInput(context, "Enter your location",
                              validateLocation, wilayaController),
                            
                          SizedBox(height: 20),
                          InputLabel("Password"),
                          PasswordFormField(
                              txtControllerPsd: passwordController),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Checkbox(
                                value: isChecked,
                                onChanged: (value) {
                                  isChecked = value ?? false;
                                },
                              ),
                              GestureDetector(
                                onTap: () {
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
                                          decoration: TextDecoration.underline,
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
                                BlocProvider.of<ClientBloc>(context).add(
                                  ClientSignupSubmitted(
                                    firstname: firstnameController.text,
                                    lastname: lastnameController.text,
                                    birthdate: birthdateController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    wilaya: TransferNametoNumber(wilayaController.text) ?? 0,
                                  ),
                                );
                              }
                            },
                            child: state is ClientLoading
                                ? CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
                                    "Create account",
                                    style: accounts_button_text_style,
                                  ),
                            style: accounts_button_style(context),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account?",
                                style: dont_have_account,
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            LoginScreenClient()),
                                  );
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
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
