/* class OfferModel {
  final String image;
  final String cityName; // title
  final String countryName; // location
  final double rating;
  final double price;
  final String startDate;
  final String endDate;
  final String descriptionText;
  final String category;
  final List<String> thumbnails;
  final int days;

  OfferModel({
    required this.image,
    required this.cityName,
    required this.countryName,
    required this.rating,
    required this.price,
    required this.startDate,
    required this.endDate,
    required this.descriptionText,
    required this.category,
    required this.thumbnails,
    required this.days,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    // Parsing dates and calculating the number of days
    final start = DateTime.parse(json['startDate']);
    final end = DateTime.parse(json['endDate']);
    final daysDifference = end.difference(start).inDays;

    return OfferModel(
      image: json['image'],
      cityName: json['cityName'],
      countryName: json['countryName'],
      rating: json['rating'],
      price: json['price'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      descriptionText: json['descriptionText'],
      category: json['category'],
      thumbnails: List<String>.from(json['thumbnails']),
      days: daysDifference,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'cityName': cityName,
      'countryName': countryName,
      'rating': rating,
      'price': price,
      'startDate': startDate,
      'endDate': endDate,
      'descriptionText': descriptionText,
      'thumbnails': thumbnails,
      'days': days,
    };
  }
}
 */
class OfferModel {
  final String image;
  final String cityName; // title
  final String countryName; // location
  final double rating;
  final double price;
  final String startDate;
  final String endDate;
  final String descriptionText;
  final String category;
  final List<String> thumbnails;
  final int days;

  OfferModel({
    required this.image,
    required this.cityName,
    required this.countryName,
    required this.rating,
    required this.price,
    required this.startDate,
    required this.endDate,
    required this.descriptionText,
    required this.category,
    required this.thumbnails,
    required this.days,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    // Parsing dates and calculating the number of days
    final start = DateTime.parse(json['startDate']);
    final end = DateTime.parse(json['endDate']);
    final daysDifference = end.difference(start).inDays;

    return OfferModel(
      image: json['image'],
      cityName: json['cityName'],
      countryName: json['countryName'],
      rating: json['rating'],
      price: json['price'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      descriptionText: json['descriptionText'],
      category: json['category'],
      thumbnails: List<String>.from(json['thumbnails']),
      days: daysDifference,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'cityName': cityName,
      'countryName': countryName,
      'rating': rating,
      'price': price,
      'startDate': startDate,
      'endDate': endDate,
      'descriptionText': descriptionText,
      'thumbnails': thumbnails,
      'days': days,
    };
  }
}