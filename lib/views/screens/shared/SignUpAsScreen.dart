import 'package:flutter/material.dart';
import 'package:triptip/views/screens/agency/signup_agency.dart';
import 'package:triptip/views/screens/client/signup_client.dart';
import 'package:triptip/views/widgets/logos.dart';
import 'package:triptip/views/widgets/BottomNaviagtionBarClient.dart';

enum SignUpAs { Client, Agency }
SignUpAs role = SignUpAs.Client;

class SignUpChoicePage extends StatelessWidget {
  static const pageRoute = '/SignAppUs';
  
  const SignUpChoicePage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Enhanced Logo Section
            trip2(context),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and subtitle with enhanced styling
                  const Text(
                    'Create account',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2F2F2F),
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: size.width * 0.8,
                    child: const Text(
                      'Get the best out of TripTip by creating an account',
                      style: TextStyle(
                        color: Color(0xFF757575),
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Enhanced choice cards
                  _buildEnhancedChoiceCard(
                    context: context,
                    icon: Icons.person,
                    title: 'Client Account',
                    description: 'Create a personal account to plan your trips',
                    onTap: () {
                      role = SignUpAs.Client;
                      Navigator.pushNamed(context, SignUpClient.pageRoute);
                    },
                  ),

                  const SizedBox(height: 20),

                  _buildEnhancedChoiceCard(
                    context: context,
                    icon: Icons.business,
                    title: 'Agency Account',
                    description: 'Create a business account to manage travel services',
                    onTap: () {
                      role = SignUpAs.Agency;
                      Navigator.pushNamed(context, SignUpAgency.pageRoute);
                    },
                  ),

                  const SizedBox(height: 40),

                  const SizedBox(height: 32),

                  // Enhanced login link
                 
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBarExampleClient(),
    );
  }

  Widget _buildEnhancedChoiceCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE0E0E0)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF20B2AA).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: const Color(0xFF20B2AA),
                    size: 28,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2F2F2F),
                          letterSpacing: 0.3,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        description,
                        style: const TextStyle(
                          color: Color(0xFF757575),
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xFF20B2AA),
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
