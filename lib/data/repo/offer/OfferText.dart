import 'package:triptip/data/repo/review_agency/ReviewText.dart';
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
  static const backGroundImage = 'assets/images/backgroundimage.jpeg';
  static const List<String> offerImageUrls = [
    'assets/images/offer1.png',
    'assets/images/offer2.png',
    'assets/images/offer3.png',
    'assets/images/offer4.png',
  ];

}