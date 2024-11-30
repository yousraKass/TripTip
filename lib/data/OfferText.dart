class AppTexts {
  //Offer info
  static const priceTitle = 'Price';
  static const startDateTitle = 'Start date';
  static const endDateTitle = 'End date';

  // Tabs
  final String offerDetailsTitle = 'Offer details';
  static const descriptionTab = 'Description';
  static const reviewTab = 'Review';
  static const readMore = 'Read More';
  static const readLess = 'Read Less';

  // Review Section
  static const reviewSummary = 'Review summary';
  static const reviewsTitle = 'Reviews';
  static const viewAll = 'View all';
  static const writeReviewPlaceholder = 'Write your review...';
  // Review Data
}

class Offertext {

  static const List<double> ratingValues = [
    0.8, // 5 stars rating
    0.15, // 4 stars rating
    0.05, // 3 stars rating
    0.025, // 2 stars rating
    0.0 // 1 star rating
  ];

}

class imagePaths {
  static const backGroundImage = 'assets/backgroundimage.jpeg';
  static const List<String> offerImageUrls = [
    'assets/offer1.png',
    'assets/offer2.png',
    'assets/offer3.png',
    'assets/offer4.png',
  ];

  static const List<String> profilePictures = [
    'assets/pfp1.png',
    'assets/pfp2.png',
    'assets/pfp3.png',
    'assets/pf4.png',
  ];
}

class OfferService {
  Future<OfferData> getOfferDetails() async {
    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    return OfferData(
      cityName: 'Annaba',
      countryName: 'Algeria',
      rating: '4.7',
      priceDescription: '20.000DA',
      startDate: '02/08/2024',
      endDate: '15/08/2024',
      descriptionText:
          'Annaba captivates visitors with its perfect blend of natural beauty and rich history, '
          'offering a unique experience that bridges ancient civilizations with stunning landscapes. '
          'Located in the northeastern corner of Algeria, this coastal city is blessed with pristine beaches, rolling hills, '
          'and the shimmering waters of the Mediterranean. The surrounding landscapes are dotted with lush olive groves and vibrant green fields, '
          'while the nearby Tassili Mountains add a dramatic backdrop to the city’s charm.',
      images: imagePaths.offerImageUrls,
      reviews: await getReviews(),
    );
  }
}

Future<List<Review>> getReviews() async {
  // Simulate API call
  await Future.delayed(
      Duration(seconds: 2)); // Adjusted to match the async nature

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
        time = '${hoursAgo} hours ago';
      }

      // Randomly generate reviews with different content
      String reviewText = index % 2 == 0
          ? 'This offer was amazing! I had such a great experience.'
          : 'I really enjoyed my time, but there were a few things that could be better. Overall, a good experience.';

      // Return a new review object for each item
      return Review(
        user: User(
          name: 'User ${index + 1}', // Dynamic user name
          profilePicturePath: imagePaths.profilePictures[index %
              imagePaths.profilePictures.length], // Randomize profile image
        ),
        time: time,
        review: reviewText,
      );
    },
  );
}

// models/offer_data.dart
class OfferData {
  final String cityName;
  final String countryName;
  final String rating;
  final String priceDescription;
  final String startDate;
  final String endDate;
  final String descriptionText;
  final List<String> images;
  final List<Review> reviews;

  OfferData({
    required this.cityName,
    required this.countryName,
    required this.rating,
    required this.priceDescription,
    required this.startDate,
    required this.endDate,
    required this.descriptionText,
    required this.images,
    required this.reviews,
  });
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
