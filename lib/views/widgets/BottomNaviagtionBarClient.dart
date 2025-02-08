import 'package:flutter/material.dart';
import 'package:triptip/views/themes/colors.dart';
import 'package:triptip/views/screens/shared/landing_page.dart';
import 'package:triptip/views/screens/client/notifications_client.dart';

import 'package:triptip/views/screens/client/favorite_page.dart';
import 'package:triptip/views/screens/shared/search_page.dart';
import 'package:triptip/views/screens/shared/SignUpAsScreen.dart';

class BottomNavigationBarExampleClient extends StatefulWidget {
  const BottomNavigationBarExampleClient({super.key});

  @override
  _BottomNavigationBarExampleClientState createState() =>
      _BottomNavigationBarExampleClientState();
}

class _BottomNavigationBarExampleClientState
    extends State<BottomNavigationBarExampleClient> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        print('Home tapped');
        Navigator.pushNamed(context, LandingPage.pageRoute);
        break;
      case 1:
        print('Notifications tapped');
        Navigator.pushNamed(context, NotificationsClient.pageRoute);
        break;
      case 3:
        print('Favorites tapped');
        Navigator.pushNamed(context, FavoritePage.pageRoute);
        break;
      case 4:
        print('Profile tapped');
        Navigator.pushNamed(context, SignUpChoicePage.pageRoute);
        break;
      default:
        print('Unknown item tapped');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Bottom Navigation Bar Container
        Container(
          decoration: const BoxDecoration(
            color: Color(0xFFD9FFFF),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            selectedItemColor: AppColors.second,
            unselectedItemColor: AppColors.fourth,
            onTap: _onItemTapped,
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/home.png',
                  height: 24,
                  width: 24,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/notification.png',
                  height: 24,
                  width: 24,
                ),
                label: 'Notifications',
              ),
              const BottomNavigationBarItem(
                icon: SizedBox.shrink(), // Placeholder for spacing
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/favorites.png',
                  height: 24,
                  width: 24,
                ),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/profile.png',
                  height: 24,
                  width: 24,
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),

        //Ellipse as the Background at the Center
        Positioned(
          top: -31, // Move the Ellipse slightly upward from the navbar
          left:
              MediaQuery.of(context).size.width / 2 - 50, // Center the Ellipse
          child: SizedBox(
            height: 100,
            width: 100,
            child: Image.asset(
              'assets/icons/nav_circle.png', // Your Ellipse image
              fit: BoxFit.contain,
            ),
          ),
        ),

        // Floating Search Button on Top of the Ellipse
        // Floating Search Button on Top of the Ellipse
        Positioned(
          top: -28, // Align the button on top of the Ellipse
          left:
              MediaQuery.of(context).size.width / 2 - 27, // Center the Ellipse
          child: Material(
            color:
                Colors.transparent, // Make the Material background transparent
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, SearchPage.pageRoute);
                // Add your search button action here
              },
              borderRadius: BorderRadius.circular(50), // Circular ripple effect
              child: Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  color: AppColors.second,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.search,
                  color: AppColors.white,
                  size: 30,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
