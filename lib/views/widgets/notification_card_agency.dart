
import 'package:flutter/material.dart';
import 'package:triptip/views/themes/colors.dart';
import 'package:triptip/views/themes/fonts.dart';

class NotificationCard extends StatelessWidget {
  final String title;
  final String time;
  final String image;
  final bool is_read;

  const NotificationCard(
      {Key? key,
      required this.title,
      required this.time,
      required this.image,
      required this.is_read})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color background_color = AppColors.white;
    if (is_read) {
      background_color = AppColors.main.withOpacity(0.1);
    }

    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: background_color,
        border: const Border(
          top: BorderSide(
            color: AppColors.second, // Top border color
            width: 0.5, // Top border width
          ),
          bottom: BorderSide(
            color: AppColors.second, // Bottom border color
            width: 1, // Bottom border width
          ),
          left: BorderSide.none, // No left border
          right: BorderSide.none, // No right border
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 50,
            height: 50,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                image,
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: FontFamily.medium,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 12,
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
