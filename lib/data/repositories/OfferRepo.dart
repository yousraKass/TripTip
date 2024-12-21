import '../models/OfferModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OfferRepo {
  final String apiUrl = "https://random.com";

  Future<OfferModel> fetchTopOffer() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final Map<String, dynamic> offerJson = json.decode(response.body);
      return OfferModel.fromJson(offerJson);
    } else {
      throw Exception("Failed To Fetch Top Offer");
    }
  }

  Future<List<OfferModel>> fetchOffers() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final List<dynamic> categoriesJson = json.decode(response.body);
      return categoriesJson.map((json) => OfferModel.fromJson(json)).toList();
    } else {
      throw Exception("Failed To Fetch Orders");
    }
  }

  Future<List<OfferModel>> fetchcategories() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final List<dynamic> categoriesJson = json.decode(response.body);
      return categoriesJson.map((json) => OfferModel.fromJson(json)).toList();
    } else {
      throw Exception("Failed To Fetch Orders");
    }
  }

  Future<List<OfferModel>> fetchPlaces() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final List<dynamic> categoriesJson = json.decode(response.body);
      return categoriesJson.map((json) => OfferModel.fromJson(json)).toList();
    } else {
      throw Exception("Failed To Fetch Orders");
    }
  }
}
