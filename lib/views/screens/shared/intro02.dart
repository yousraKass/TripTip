import 'package:flutter/material.dart';
import 'intro03.dart';
import '/views/themes/colors.dart';
import '/views/themes/fonts.dart'; 

class Intro02 extends StatelessWidget {
  static const pageRoute = '/Intro02';
  const Intro02({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/back_intro02.png',
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Where do you want to go?',
                  style: TextStyle(
                    fontFamily: FontFamily.bold,
                    fontSize: 28,
                    color: AppColors.white,
                  ),
                ),
                SizedBox(height: 10),
                const Text(
                  'Select the agency that offers the best deals, make your own Trip.',
                  style: TextStyle(
                    fontFamily: FontFamily.regular,
                    fontSize: 16,
                    color: AppColors.white,
                  ),
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.main,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Intro03()),
                      );
                    },
                    child: const Text(
                      'Next',
                      style: TextStyle(
                        fontFamily: FontFamily.medium,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
