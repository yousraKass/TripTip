
Future<List<Review>> getReviews() async {
  // Simulate API call
  // await Future.delayed(
  //     const Duration(seconds: 2)); // Adjusted to match the async nature

  // Generate some sample users and reviews
  return List.generate(
    15,
    (index) {
      String time;
      int hoursAgo = (index + 1) * 2; // Randomized time in hours

      // Simulate time in hours ago (e.g., 2 hours ago, 4 hours ago, etc.)
      if (hoursAgo == 2) {
        time = '2 hours ago';
      } else if (hoursAgo == 4) {
        time = '4 hours ago';
      } else if (hoursAgo == 6) {
        time = '6 hours ago';
      } else {
        time = '$hoursAgo hours ago';
      }

      // Randomly generate reviews with different content
      String reviewText = index % 2 == 0
          ? 'This offer was amazing! I had such a great experience.'
          : 'I really enjoyed my time, but there were a few things that could be better. Overall, a good experience.';

      // Return a new review object for each item
      return Review(
        user: User(
          name: 'User ${index + 1}', // Dynamic user name
          profilePicturePath: profilePicturePaths.profilePictures[index %
              profilePicturePaths.profilePictures.length], // Randomize profile image
        ),
        time: time,
        review: reviewText,
      );
    },
  );
}



class User {
  final String name;
  final String profilePicturePath;

  User({
    required this.name,
    required this.profilePicturePath,
  });
}

class Review {
  final User user; // Using the User class here
  final String time;
  final String review;

  Review({
    required this.user,
    required this.time,
    required this.review,
  });
}

class profilePicturePaths {

  static const List<String> profilePictures = [
    'assets/images/pfp1.png',
    'assets/images/pfp2.png',
    'assets/images/pfp3.png',
    'assets/images/pfp4.png',
  ];

}