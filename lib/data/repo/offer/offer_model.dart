//this file to define variable and data needed for each offer
class OfferModel {
  final String image;
  final String title;
  final String location;
  final double rating;
  final String price;
  final int days;
  final List<String> thumbnails;

  OfferModel({
    required this.image,
    required this.title,
    required this.location,
    required this.rating,
    required this.price,
    required this.days,
    required this.thumbnails,
  });
}

// Dummy data
final List<OfferModel> dummyOffers = [
  OfferModel(
    image: 'assets/images/offer1.png',
    title: 'To-Oran',
    location: 'Algeria',
    rating: 4.8,
    price: '40000',
    days: 5,
    thumbnails: [
      'assets/images/offer1.png',
      'assets/images/offer2.png',
      'assets/images/offer3.png',
    ],
  ),
  OfferModel(
    image: 'assets/images/offer2.png',
    title: 'To-maldives',
    location: 'Algeria',
    rating: 4.7,
    price: '45000',
    days: 6,
    thumbnails: [
      'assets/images/offer1.png',
      'assets/images/offer2.png',
      'assets/images/offer3.png',
    ],
  ),
  OfferModel(
    image: 'assets/images/offer3.png',
    title: 'To-Paris',
    location: 'Algeria',
    rating: 4.9,
    price: '50000',
    days: 7,
    thumbnails: [
      'assets/images/offer1.png',
      'assets/images/offer2.png',
      'assets/images/offer3.png',
    ],
  ),
    OfferModel(
    image: 'assets/images/offer4.png',
    title: 'To-Oran',
    location: 'Algeria',
    rating: 3,
    price: '40000',
    days: 5,
    thumbnails: [
      'assets/images/offer1.png',
      'assets/images/offer2.png',
      'assets/images/offer3.png',
    ],
  ),
  OfferModel(
    image: 'assets/images/offer4.png',
    title: 'To-maldives',
    location: 'Algeria',
    rating: 2,
    price: '45000',
    days: 6,
    thumbnails: [
      'assets/images/offer1.png',
      'assets/images/offer2.png',
      'assets/images/offer3.png',
    ],
  ),
  OfferModel(
    image: 'assets/images/offer4.png',
    title: 'To-Paris',
    location: 'Algeria',
    rating: 5,
    price: '50000',
    days: 7,
    thumbnails: [
      'assets/images/offer1.png',
      'assets/images/offer2.png',
      'assets/images/offer3.png',
    ],
  ),

];