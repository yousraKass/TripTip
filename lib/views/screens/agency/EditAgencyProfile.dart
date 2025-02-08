import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triptip/blocs/agency/agency_bloc.dart';
import 'package:triptip/blocs/agency/agency_event.dart';
import 'package:triptip/blocs/agency/agency_state.dart';
import 'package:triptip/data/models/agency/agency_model.dart';
import 'package:triptip/views/themes/fonts.dart';
import 'package:triptip/views/themes/colors.dart';
import 'package:triptip/views/widgets/BottomNaviagtionBarClient.dart';
import 'package:shared_preferences/shared_preferences.dart';


class EditAgencyProfileScreen extends StatelessWidget {
  static const pageRoute = '/EditAgencyProfile';

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _websiteController = TextEditingController();
  final _aboutController = TextEditingController();


  EditAgencyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocConsumer<AgencyBloc, AgencyState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            _initializeControllers(state.agency);
          }
          if (state is EditProfileSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Profile updated successfully')),
            );
          }
          if (state is AgencyFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.error}')),
            );
          }
        },
        builder: (context, state) {
          if (state is AgencyLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
              child: Column(
            children: [
              _buildHeader(
                  state is LoginSuccess ? state.agency : null, context),
              _buildForm(context, state is LoginSuccess ? state.agency : null),
            ],
          ));
        },
      ),
      bottomNavigationBar: BottomNavigationBarExampleClient(),
    );
  }

  void _initializeControllers(AgencyModel agency) {
    _nameController.text = agency.name ?? '';
    _emailController.text = agency.email;
    _phoneController.text = agency.phoneNumber ?? '';
    _aboutController.text = agency.aboutUs ?? '';
  }

  Widget _buildHeader(AgencyModel? agency, BuildContext context) {
    return Stack(
      children: [
        Stack(
          children: [
            // Shadow effect
            ClipPath(
              clipper: HeaderClipper(),
              child: Container(
                height: 283,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.grey.withOpacity(0.5),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // Background Image - You might want to handle this differently
            ClipPath(
              clipper: HeaderClipper(),
              child: Container(
                height: 280,
                decoration: const BoxDecoration(
                  color: AppColors
                      .main, // Placeholder until image handling is implemented
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 30,
                      right: 20,
                      child: IconButton(
                        icon: Container(
                          padding: const EdgeInsets.all(3),
                          child: SizedBox(
                            height: 28,
                            width: 28,
                            child: Image.asset(
                              'assets/icons/appareil-photo.png',
                              color: AppColors.black,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        onPressed: () {
                          // TODO: Implement image upload
                        },
                      ),
                    ),
                    Positioned(
                      top: 20,
                      left: 10,
                      child: IconButton(
                        icon: SizedBox(
                          height: 50,
                          width: 50,
                          child: Image.asset(
                            'assets/icons/back.png',
                            height: 30,
                            width: 30,
                            color: AppColors.main,
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),

        // Logo and Title
        Positioned(
          top: 170,
          left: 60,
          child: Column(
            children: [
              const CircleAvatar(
                radius: 60,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 60, color: AppColors.main),
              ),
            ],
          ),
        ),
        _buildTitle(agency),
      ],
    );
  }

  Widget _buildTitle(AgencyModel? agency) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 280, 0, 0),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'Change Profile Picture',
                style: TextStyle(
                  color: AppColors.main,
                  fontFamily: FontFamily.medium,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(width: 10),
              IconButton(
                icon: SizedBox(
                  height: 20,
                  width: 20,
                  child: Image.asset(
                    'assets/icons/camera.png',
                    height: 30,
                    width: 30,
                    color: AppColors.black,
                  ),
                ),
                onPressed: () {
                  // Handle camera button press
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Row(
              children: [
                Text(
                  agency?.name ?? 'Agency Name',
                  style: const TextStyle(
                    color: AppColors.black,
                    fontFamily: FontFamily.medium,
                    fontSize: 27,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm(BuildContext context, AgencyModel? agency) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            _buildFormField(
              label: 'Our website:',
              hintText: '(Add the link)',
              controller: _websiteController,
              trailingIcon: 'assets/icons/link.png',
              onIconPressed: () {
                print("Icon Pressed");
              },
              validator: _validateWebsite,
            ),
            _buildFormField(
              label: 'Email',
              hintText: 'Enter email',
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              validator: _validateEmail,
            ),
            _buildFormField(
              label: 'Phone',
              hintText: '0579xxxxx',
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              validator: _validatePhone,
            ),
            _buildFormField(
              label: 'Address',
              hintText: 'Enter address',
              controller: _addressController,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text(
                  'Other ways to\ncontact me',
                  style: TextStyle(
                    color: AppColors.black,
                    fontFamily: FontFamily.medium,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 130),
                _buildSocialMediaButtons(),
              ],
            ),
            const Divider(
                color: Color.fromARGB(234, 224, 224, 224), thickness: 2.0),
            const SizedBox(height: 20),
            _buildAboutUsSection(context),
            const SizedBox(height: 30),
            _buildSaveButton(context),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutUsSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 15, 0, 15),
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey, width: 0.2),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'About ',
                style: TextStyle(
                  color: AppColors.black,
                  fontFamily: FontFamily.medium,
                  fontSize: 16,
                ),
              ),
              const Text(
                'US',
                style: TextStyle(
                  color: AppColors.main,
                  fontFamily: FontFamily.medium,
                  fontSize: 17,
                ),
              ),
              IconButton(
                icon: Image.asset('assets/icons/edite2.png'),
                onPressed: () {
                  // TODO: Implement editing functionality
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _aboutController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Tell us about your agency...',
              hintStyle: TextStyle(
                color: AppColors.black.withOpacity(0.5),
                fontFamily: FontFamily.regular,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.main),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColors.main.withOpacity(0.5)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.main, width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 100,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _saveProfileChanges(context);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.main,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            'Save',
            style: TextStyle(
              color: AppColors.white,
              fontFamily: FontFamily.medium,
              fontSize: 17,
            ),
          ),
        ),
      ),
    );
  }

  void _saveProfileChanges(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('user_token') ?? '';

    final agencyBloc = context.read<AgencyBloc>();

    final agency = AgencyModel(
      password: "",
      name: _nameController.text,
      email: _emailController.text,
      phoneNumber: _phoneController.text,
      aboutUs: _aboutController.text,
      offers: [], // Add the required 'offers' parameter
    );

    agencyBloc.add(AgencyEditProfileSubmitted(
      name: agency.name ?? '',
      email: agency.email ?? '',
      password: '', // You might want to handle password differently
      phoneNumber: agency.phoneNumber ?? '',
      location: '', // You might want to get this from somewhere
      aboutUs: agency.aboutUs,
    ));
  }

  // Validation Methods
  String? _validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Please enter an email address';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validatePhone(String? phone) {
    if (phone == null || phone.isEmpty) {
      return 'Please enter a phone number';
    }
    final phoneRegex = RegExp(r'^0[5-7]\d{8}$');
    if (!phoneRegex.hasMatch(phone)) {
      return 'Please enter a valid Algerian phone number';
    }
    return null;
  }

  String? _validateWebsite(String? website) {
    if (website == null || website.isEmpty) {
      return null; // Optional field
    }
    final websiteRegex = RegExp(
      r'^(https?://)?([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}(/\S*)?$',
      caseSensitive: false,
    );
    if (!websiteRegex.hasMatch(website)) {
      return 'Please enter a valid website URL';
    }
    return null;
  }

  // Social Media Buttons
  Widget _buildSocialMediaButtons() {
    return Row(
      children: [
        _socialMediaButton(
          icon: 'assets/icons/fbicon.png',
          onPressed: () {
            // Handle Facebook link
          },
        ),
        _socialMediaButton(
          icon: 'assets/icons/instagram.png',
          onPressed: () {
            // Handle Instagram link
          },
        ),
      ],
    );
  }

  Widget _socialMediaButton({
    required String icon,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Image.asset(
          icon,
          width: 24,
          height: 24,
        ),
      ),
    );
  }
}

// Custom Clipper for the Header Curve
class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 80);

    // First wave segment
    path.quadraticBezierTo(
      size.width * 0.3,
      size.height - 165,
      size.width * 0.6,
      size.height - 75,
    );

    // Second wave segment
    path.quadraticBezierTo(
      size.width * 0.85,
      size.height - 20,
      size.width,
      size.height - 50,
    );

    // Connect to top-right corner
    path.lineTo(size.width, 0);

    // Close the path
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

// Form Field Builder Method
Widget _buildFormField({
  required String label,
  required String hintText,
  required TextEditingController controller,
  TextInputType keyboardType = TextInputType.text,
  String? trailingIcon,
  VoidCallback? onIconPressed,
  String? Function(String?)? validator,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Text(
                label,
                style: const TextStyle(
                  color: AppColors.black,
                  fontFamily: FontFamily.medium,
                  fontSize: 16,
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: TextFormField(
                controller: controller,
                keyboardType: keyboardType,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: TextStyle(
                    color: AppColors.black.withOpacity(0.5),
                    fontFamily: FontFamily.regular,
                  ),
                  border: InputBorder.none,
                ),
                validator: validator ??
                    (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please fill in this field';
                      }
                      return null;
                    },
              ),
            ),
            if (trailingIcon != null)
              IconButton(
                icon: Image.asset(trailingIcon, color: AppColors.black),
                onPressed: onIconPressed,
              ),
          ],
        ),
        const Divider(
          color: Color.fromARGB(234, 224, 224, 224),
          thickness: 2.0,
        ),
      ],
    ),
  );
}
