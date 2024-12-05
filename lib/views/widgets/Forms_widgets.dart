import 'package:flutter/material.dart';
import 'package:triptip/views/themes/colors.dart';
import 'package:triptip/views/themes/style.dart';

Widget InputLabel(String label) {
  return Padding(
    padding: const EdgeInsets.only(left: 5.0),
    child: Text(
      label,
      style: field_label,
    ),
  );
}

Widget UserInput(BuildContext context, String placeholder, Function validate,
    TextEditingController? txt_controller) {
  return Center(
    child: Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: TextFormField(
        decoration: InputDecoration(
          hintText: placeholder,
          hintStyle: field_hint,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade500,                                    
              width: 0.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade500, // Set the border color when the field is enabled
              width: 0.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.main, // Set the border color when the field is focused
              width: 0.5,
            ),
          ),
        ),
        controller: txt_controller,
        validator: (value) {
          return validate(value);
        },
      ),
    ),
  );
}

Widget LoginInWith() {
  return Row(
    children: [
      Expanded(
        child: Divider(
          thickness: 0.5, // Adjust the thickness as needed
          color: Colors.grey, // Set the color of the line
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Text('Or login with'),
      ),
      Expanded(
        child: Divider(
          thickness: 0.5, // Adjust the thickness as needed
          color: Colors.grey, // Set the color of the line
        ),
      ),
    ],
  );
}