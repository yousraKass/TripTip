import 'package:flutter/material.dart';
import 'package:triptip/views/widgets/BottomNavigationBarAgency.dart';
import 'package:triptip/views/themes/colors.dart';
import 'package:triptip/views/themes/fonts.dart';
import 'EditAgencyProfile.dart';
import 'notifications_agency.dart';

class SettingsScreenAgency extends StatelessWidget {
  static const pageRoute = '/SettingsScreenAgency';
  const SettingsScreenAgency({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor:  AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[100],
            ),
            child: const Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.black,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  const Text('Settings',
                  style: TextStyle(
                    fontFamily: FontFamily.bold,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),),
                  const SizedBox(height: 10),
                  _buildSettingItem(
                    icon: Icons.notifications_outlined,
                    title: 'Notification',
                    onTap: () {
                      Navigator.pushNamed(context, NotificationsAgency.pageRoute);
                    },
                    iconColor: const Color(0xFF00BFB3),
                  ),
                  _buildSettingItem(
                    icon: Icons.person_outline,
                    title: 'Edit profile',
                    onTap: () {
                      Navigator.pushNamed(context, EditAgencyProfileScreen.pageRoute);
                    },
                    iconColor: const Color(0xFF00BFB3),
                  ),
                  _buildSettingItem(
                    icon: Icons.language_outlined,
                    title: 'Change language',
                    onTap: () {},
                    iconColor: const Color(0xFF00BFB3),
                  ),
                  _buildSettingItem(
                    icon: Icons.dark_mode_outlined,
                    title: 'Color mode',
                    onTap: () {},
                    iconColor: const Color(0xFF00BFB3),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Derleng Legal',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  _buildLegalItem(
                    icon: Icons.description_outlined,
                    title: 'Terms and Condition',
                    onTap: () {},
                  ),
                  _buildLegalItem(
                    icon: Icons.shield_outlined,
                    title: 'Privacy policy',
                    onTap: () {},
                  ),
                  const SizedBox(height: 20),
                  _buildLogoutButton(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBarExampleAgency(),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.grey, // Border color
          width: 0.3, // Border width
        ),
        
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: iconColor,
          size: 24,
        ),
        
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: AppColors.black,
        ),
        onTap: onTap,
      ),
    );
  }

  Widget _buildLegalItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.grey, // Border color
          width: 0.3, // Border width
        ),
        
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: const Color(0xFF00BFB3),
          size: 24,
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: const Icon(
          Icons.open_in_new,
          size: 16,
          color: AppColors.black,
        ),
        onTap: onTap,
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Container(
      width: double.infinity,
      height: 55,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFF00BFB3),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: const BorderSide(
              color: Color(0xFF00BFB3),
              width: 2,
            ),
          ),
        ),
        child: const Text(
          'Logout',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
