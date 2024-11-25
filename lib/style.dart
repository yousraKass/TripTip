import 'package:flutter/material.dart';

class AppColors {
  static const Color main = Color(0x18C1C0);
  static const Color second = Color(0x099094);
  static const Color third = Color(0x2A6567);
  static const Color fourth = Color(0x264653);
  static const Color black = Color(0x000000);
  static const Color white = Color(0xFFFFFF);
}

class FontFamily {
  static const String regular = 'Poppins-Regular';
  static const String medium = 'Poppins-Medium';
  static const String bold = 'Poppins-Bold';
}

Widget trip2(BuildContext context) {
  return Image.asset(
    "assets/logo/trip2.png",
    width: MediaQuery.of(context).size.width,
    fit: BoxFit.cover,
  );
}