import 'package:flutter/material.dart';
import 'package:triptip/data/OfferText.dart';

// class ReviewItem extends StatelessWidget {
//   final User user;  // Receive the user object
//   final String time;
//   final String review;

//   ReviewItem({
//     required this.user,  // Pass the user object here
//     required this.time,
//     required this.review,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 25),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               CircleAvatar(
//                 backgroundColor: Colors.grey[200],
//                 radius: 20,
//                 backgroundImage: AssetImage(user.profilePicturePath), // Display the profile picture here
//               ),
//               SizedBox(width: 16),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       user.name,  // Show the user name
//                       style:
//                           TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                     ),
//                     SizedBox(height: 2),
//                     Text(
//                       time,
//                       style: TextStyle(color: Colors.grey, fontSize: 12),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 8),
//           Text(
//             review,
//             style: TextStyle(fontSize: 14),
//           ),
//         ],
//       ),
//     );
//   }
// }


class ReviewItem extends StatelessWidget {
  final User user;
  final String time;
  final String review;

  ReviewItem({
    required this.user,
    required this.time,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25),
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
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(height: 2),
                    Text(
                      time,
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            review,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
