import 'package:flutter/material.dart';
import 'package:triptip/views/themes/colors.dart';
import 'package:triptip/views/themes/style.dart';
import 'package:triptip/views/widgets/logos.dart';
import 'package:triptip/views/widgets/BottomNavigationBar.dart';


class EditClientProfileScreen extends StatefulWidget {
  static const pageRoute = "/edit_client_profile";
  @override
  _EditClientProfileScreenState createState() =>
      _EditClientProfileScreenState();
}

class _EditClientProfileScreenState extends State<EditClientProfileScreen> {
  // Text controllers for each field
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController wilayaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          title: Text('Edit Profile', style: navbarTitle),
          backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
          leading: back_btn(context),
        ),
        bottomNavigationBar: BottomNavigationBarExample(),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              // Profile Picture
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage(
                          'assets/images/profile_picture.png'), // Replace with the user's image
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                        icon: Icon(Icons.camera_alt,
                            size: 25, color: Colors.blue),
                        onPressed: () {
                          // Add functionality to change profile picture
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // First Name Field
              TextFormField(
                controller: firstNameController,
                decoration: edit_profile_fields("First Name"),
              ),
              SizedBox(height: 10),

              // Last Name Field
              TextFormField(
                controller: lastNameController,
                decoration:edit_profile_fields("Last Name"),
              ),
              SizedBox(height: 10),

              // Email Field
              TextFormField(
                controller: emailController,
                decoration: edit_profile_fields("email"),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 10),

              // Date of Birth Field
              TextFormField(
                controller: dateOfBirthController,
                decoration: edit_profile_fields("Date of Birth"),
                keyboardType: TextInputType.datetime,
              ),
              SizedBox(height: 10),

              // Wilaya Field
              TextFormField(
                controller: wilayaController,
                decoration: edit_profile_fields("wilaya"),                
              ),
              SizedBox(height: 80),

              // Save Button
              ElevatedButton(
                onPressed: () {
                  // Handle save action here
                  // You can save the data or make an API call to update the profile
                },
                child: Text('Save', style: accounts_button_text_style),
                style: Save_changes_style(context) ,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
