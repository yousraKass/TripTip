import 'package:flutter/material.dart';
import 'package:triptip/data/ReviewText.dart';
//import 'package:triptip/data/OfferText.dart';

class ReviewItem extends StatelessWidget {
  final User user;
  final String time;
  final String review;

  const ReviewItem({super.key, 
    required this.user,
    required this.time,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey[200],
                radius: 20,
                backgroundImage: AssetImage(user.profilePicturePath),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      time,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            review,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
