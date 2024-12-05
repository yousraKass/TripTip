import 'package:flutter/material.dart';
import 'package:triptip/views/themes/fonts.dart';
import 'package:triptip/views/themes/colors.dart';

TextStyle mainTitle = TextStyle(
  fontFamily: FontFamily.medium,
  fontWeight: FontWeight.bold,
  fontSize: 24,
);

TextStyle subTitle = TextStyle(
  fontFamily: FontFamily.regular,
  fontSize: 16,
);

TextStyle description = TextStyle(
  fontFamily: FontFamily.regular,
  fontSize: 11,
);

TextStyle field_label = TextStyle(
  fontFamily: FontFamily.regular,
  fontSize: 16,
);

TextStyle field_hint = TextStyle(
  fontFamily: FontFamily.regular,
  fontSize: 14,
);

TextStyle forget_password = TextStyle(
  fontFamily: FontFamily.regular,
  color: AppColors.third,
  fontSize: 13,
);

TextStyle accounts_button_text_style = TextStyle(
  fontFamily: FontFamily.medium,
  fontSize: 16,
  color: AppColors.white,
);

SizedBox Box = SizedBox(
  height: 10,
);

EdgeInsets pdn = const EdgeInsets.all(20.0);

ButtonStyle accounts_button_style(BuildContext context) {
  return ElevatedButton.styleFrom(
    backgroundColor: AppColors.main,
    minimumSize: Size(MediaQuery.of(context).size.width * 0.92, 60),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );
}

ButtonStyle LoginInWith_button_style(BuildContext context) {
  return ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    disabledBackgroundColor: Colors.white,
    minimumSize: Size(MediaQuery.of(context).size.width * 0.5, 60),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      side: BorderSide(
        color: Colors.grey,
        width: 0.5,
      ),
    ),
    elevation: 0,
    shadowColor: Colors.transparent,
  );
}

TextStyle LoginInWith_button_text_style = TextStyle(
  fontFamily: FontFamily.medium,
  fontSize: 16,
  color: AppColors.black,
);

TextStyle dont_have_account = TextStyle(
  fontFamily: FontFamily.regular,
  fontSize: 16,
);

TextStyle create_account = TextStyle(
  fontFamily: FontFamily.medium,
  fontSize: 16,
  color: AppColors.black,
);

TextStyle navbarTitle = TextStyle(
  fontFamily: FontFamily.medium,
  fontSize: 18,
  color: AppColors.black,
);

// client profile styles

const TextStyle user_info_style = TextStyle(
  fontFamily: FontFamily.medium,
  fontSize: 16,
  color: const Color(0xFF1B1A1A),
);


// edit profile fields style
InputDecoration edit_profile_fields(String label) {
  return InputDecoration(
    labelText: label, // Optional label
    labelStyle: TextStyle(
        color: const Color.fromRGBO(
            158, 158, 158, 1)), // Customize the label style
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey), // Default border color
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
          color: Colors.blue, width: 2.0), // Border color when focused
    ),
    errorBorder: UnderlineInputBorder(
      borderSide:
          BorderSide(color: Colors.red, width: 2.0), // Border color for errors
    ),
    border: UnderlineInputBorder(), // Default behavior
  );
}


ButtonStyle Save_changes_style(BuildContext context) {
  return ElevatedButton.styleFrom(
    backgroundColor: AppColors.main,
    minimumSize: Size(MediaQuery.of(context).size.width * 0.5, 60),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    elevation: 0,
    shadowColor: Colors.transparent,
  );
}