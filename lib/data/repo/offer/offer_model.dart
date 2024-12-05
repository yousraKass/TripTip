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
    image: 'assets/img/oran_offer.png',
    title: 'To-Oran',
    location: 'Algeria',
    rating: 4.8,
    price: '40000',
    days: 5,
    thumbnails: [
      'assets/img/algiers_offer.png',
      'assets/img/oran_offer.png',
      'assets/img/constantine_offer.png',
    ],
  ),
  OfferModel(
    image: 'assets/img/maldives_offer.png',
    title: 'To-maldives',
    location: 'Algeria',
    rating: 4.7,
    price: '45000',
    days: 6,
    thumbnails: [
      'assets/img/algiers_offer.png',
      'assets/img/algiers_offer.png',
      'assets/img/algiers_offer.png',
    ],
  ),
  OfferModel(
    image: 'assets/img/oran_offer.png',
    title: 'To-Paris',
    location: 'Algeria',
    rating: 4.9,
    price: '50000',
    days: 7,
    thumbnails: [
      'assets/img/algiers_offer.png',
      'assets/img/algiers_offer.png',
      'assets/img/algiers_offer.png',
    ],
  ),
    OfferModel(
    image: 'assets/img/oran_offer.png',
    title: 'To-Oran',
    location: 'Algeria',
    rating: 3,
    price: '40000',
    days: 5,
    thumbnails: [
      'assets/img/algiers_offer.png',
      'assets/img/oran_offer.png',
      'assets/img/constantine_offer.png',
    ],
  ),
  OfferModel(
    image: 'assets/img/maldives_offer.png',
    title: 'To-maldives',
    location: 'Algeria',
    rating: 2,
    price: '45000',
    days: 6,
    thumbnails: [
      'assets/img/algiers_offer.png',
      'assets/img/algiers_offer.png',
      'assets/img/algiers_offer.png',
    ],
  ),
  OfferModel(
    image: 'assets/img/oran_offer.png',
    title: 'To-Paris',
    location: 'Algeria',
    rating: 5,
    price: '50000',
    days: 7,
    thumbnails: [
      'assets/img/algiers_offer.png',
      'assets/img/algiers_offer.png',
      'assets/img/algiers_offer.png',
    ],
  ),

];