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

class OfferService {

  Future<OfferData> getOfferDetails() async {
    // Simulate API call
    // await Future.delayed(const Duration(seconds: 2));

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
