import 'package:flutter/material.dart';
import 'intro02.dart';
import '/views/themes/colors.dart'; 

class Intro01 extends StatelessWidget {
  static const pageRoute = '/Intro01';
  const Intro01({super.key});

  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Intro02()),
        );
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                'assets/images/bacK_intro01.png',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
              Image.asset('assets/logo/trip3.png',
              width:350,
              height:400,
              ),
         
            ],
          ),
        ),
      ),
    );
  }
}
