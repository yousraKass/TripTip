import 'package:flutter/material.dart';
import 'package:triptip/views/themes/style.dart';
import 'package:triptip/views/themes/colors.dart';
import 'package:triptip/logic/form_validators.dart';


class PasswordFormField extends StatefulWidget {
  final TextEditingController txtControllerPsd; 

  const PasswordFormField({
    super.key,
    required this.txtControllerPsd,
  });

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        child: TextFormField(
          obscureText: _obscureText,
          decoration: InputDecoration(
            hintText: "Enter your password",
            hintStyle: field_hint,
            border:OutlineInputBorder(
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
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
          ),
          controller: widget.txtControllerPsd,
          validator: (value) {
            return validatePassword(value);
          },
        ),
      ),
    );
  }
}
