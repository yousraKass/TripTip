// offer_model.dart
class OfferModel {
  final int id;
  final String image;
  final String cityName; // title
  final String countryName; // location
  final double price;
  final double? rating;

  final String startDate;
  final String endDate;
  final String descriptionText;
  final String category;
  final List<String>? thumbnails;
  final int days;
  final String? transport;
  final String? meals;
  final String? guide;
  final String? hotel;

  OfferModel({
    required this.id,
    required this.image,
    required this.cityName,
    required this.countryName,
    required this.price,
    this.rating,
    required this.startDate,
    required this.endDate,
    required this.descriptionText,
    required this.category,
     this.thumbnails,
    required this.days,
     this.transport,
     this.meals,
     this.guide,
     this.hotel,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    final start = DateTime.parse(json['startDate']);
    final end = DateTime.parse(json['endDate']);
    final daysDifference = end.difference(start).inDays;

    return OfferModel(
      id: json['id'],
      image: json['image'],
      cityName: json['cityName'],
      countryName: json['countryName'],
      price: json['price'],
      rating: json['rating'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      descriptionText: json['descriptionText'],
      category: json['category'],
      thumbnails: List<String>.from(json['thumbnails']),
      days: daysDifference,
      transport: json['transport'],
      meals: json['meals'],
      guide: json['guide'],
      hotel: json['hotel'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'cityName': cityName,
      'countryName': countryName,
      'price': price,
      'rating': rating,
      'startDate': startDate,
      'endDate': endDate,
      'descriptionText': descriptionText,
      'category': category,
      'thumbnails': thumbnails,
      'days': days,
      'transport': transport,
      'meals': meals,
      'guide': guide,
      'hotel': hotel,
    };
  }
}