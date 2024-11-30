import 'package:flutter/material.dart';
import 'package:triptip/views/themes/colors.dart';

class BottomNavigationBarExample extends StatefulWidget {
  @override
  _BottomNavigationBarExampleState createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Bottom Navigation Bar Container
        Container(
          decoration: BoxDecoration(
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
              BottomNavigationBarItem(
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
          child: Container(
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
                print('Search button tapped');
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
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
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
