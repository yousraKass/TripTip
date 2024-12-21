import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triptip/bloc/agency/agency_bloc.dart';
import 'package:triptip/views/themes/style.dart';
import 'package:triptip/views/widgets/logos.dart';
import 'package:triptip/logic/form_validators.dart';
import 'package:triptip/views/themes/colors.dart';
import 'package:triptip/views/widgets/Forms_widgets.dart';
import 'package:triptip/views/screens/agency/login_page_agency.dart';
import 'package:triptip/bloc/shared/password_visibility_bloc.dart';
import 'package:triptip/bloc/agency/agency_event.dart';
import 'package:triptip/bloc/agency/agency_state.dart';
import 'package:triptip/bloc/shared/password_event_visible.dart';
import 'package:triptip/bloc/shared/password_state_visible.dart';
import 'package:triptip/data/repositories/agency/agency_repo.dart';


class SignUpAgency extends StatelessWidget {
  SignUpAgency({super.key});
     static const pageRoute = "/SignUpAgency";
      late final agencyRepository = AgencyRepository();
      late final   signupBloc = AgencyBloc(repository: agencyRepository);
  // Controllers for form fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  // Form Key
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    bool isChecked = false;
    return BlocProvider(
      create: (context) => signupBloc, 
      child: Scaffold(
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
                      "Create your account",
                      style: mainTitle,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Join TripTip and explore endless possibilities",
                      style: subTitle, 
                    ),
                    SizedBox(height: 30),
                    BlocListener<AgencyBloc, AgencyState>(
                      listener: (context, state) {
                        if (state is SignupSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Signup Successful!')),
                          );
                          Navigator.pushNamed(context, '/login');
                        } else if (state is AgencyFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.error)),
                          );
                        }
                      },
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Name Field
                            InputLabel("Agency's name"),
                          UserInput(context, "Enter agency name",
                              validateAgencyName, nameController),
                            SizedBox(height: 20),

                            // agency phone
                          InputLabel("Phone"),
                          UserInput(context, 'Enter phone number',
                              validatePhoneNumber, phoneController),
                            SizedBox(height: 20),

                            // agency email
                          InputLabel("Agency email"),
                          UserInput(context, "Enter agency email",
                              validateEmail, emailController),
                            SizedBox(height: 20),

                            // agency location
                          InputLabel("Agency location"),
                          UserInput(context, "Enter agency location",
                              validateLocation, locationController),
                            SizedBox(height: 20),

                         
                            // Password Field
                            InputLabel("Password"),
                            Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: BlocBuilder<PasswordVisibilityBloc, PasswordVisibilityState>(
                                  builder: (context, state) {
                                    return TextFormField(
                                      obscureText: !state.isPasswordVisible,
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
                                            color: Colors.grey.shade500,
                                            width: 0.5,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppColors.main,
                                            width: 0.5,
                                          ),
                                        ),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            state.isPasswordVisible
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                          ),
                                          onPressed: () {
                                            context.read<PasswordVisibilityBloc>().add(TogglePasswordVisibility());
                                          },
                                        ),
                                      ),
                                      controller: passwordController,
                                      validator: validatePassword,
                                    );
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 20),

                            // Terms & Conditions
                            Row(
                            children: [
                              // Checkbox
                              Checkbox(
                                value: isChecked,
                                onChanged: (value) {
                                    isChecked = value ?? false;
                                    
                                },
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

                            // Submit Button
                            BlocBuilder<AgencyBloc, AgencyState>(
                              builder: (context, state) {
                                return ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      BlocProvider.of<AgencyBloc>(context).add(
                                        AgencySignupSubmitted(
                                          name: nameController.text,
                                          email: emailController.text,
                                          password: passwordController.text,
                                          phoneNumber: phoneController.text,
                                          location: TransferNametoNumber(locationController.text) ?? 0,
                                        ),
                                      );
                                    }
                                  },
                                  style: accounts_button_style(context),
                                  child: state is AgencyLoading
                                      ? CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                      : Text(
                                          "Create Account",
                                          style: accounts_button_text_style,
                                        ),
                                );
                              },
                            ),
                            SizedBox(height: 20),

                            // Login Prompt
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
                                          builder: (context) => LoginPageAgency()),
                                    );
                                  },
                                  child: Text(
                                    'Log In',
                                    style: create_account,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
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
