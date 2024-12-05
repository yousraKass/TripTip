import 'package:flutter/material.dart';
import 'package:triptip/views/themes/colors.dart';

Widget PreferenceCell(
    BuildContext context, Map<String, dynamic> data, String page) {
  Color cell_color = Colors.transparent;
  if (data["selected"] && page == "preferences") {
    cell_color = AppColors.main.withOpacity(0.5);
  }
  return Column(
    children: [
      Stack(
        children: [
          Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(data["image"]),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          // Semi-transparent overlay // Apply color overlay if condition is true
          Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              color: cell_color, // Semi-transparent overlay
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ],
      ),
      Text(data["label"]),
    ],
  );
}
