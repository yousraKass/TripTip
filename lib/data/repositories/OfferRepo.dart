import '../models/OfferModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class OfferRepo {
  final String baseUrl = 'http://localhost:3000/TripTip';
  // Method to get JWT token from storage
  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Helper method to create authenticated headers
  Future<Map<String, String>> _getAuthHeaders() async {
    final token = await _getToken();
    return {
      'Content-Type': 'application/json',
    };
  }

    Future<OfferModel> fetchTopOffer() async {
    final headers = await _getAuthHeaders();
    final response = await http.get(
      Uri.parse('$baseUrl/ChosenOffers'),
      headers: headers,
    );
    print(response.body);
    if (response.statusCode == 200) {
      final List<dynamic> offersJson = json.decode(response.body);
      // Take the first offer from the list
      if (offersJson.isNotEmpty) {
        return OfferModel.fromJson(offersJson[0]);
      } else {
        throw Exception("No top offers available");
      }
    } else if (response.statusCode == 401) {
      throw Exception("Unauthorized - Please login again");
    } else {
      throw Exception("Failed To Fetch Top Offer: ${response.statusCode}");
    }
  }

  Future<List<OfferModel>> fetchOffers() async {
    final headers = await _getAuthHeaders();
    final response = await http.get(
      Uri.parse('$baseUrl/RecommendedOffers'),
      headers: headers,
    );
    print(response.body);
    if (response.statusCode == 200) {
      final List<dynamic> offersJson = json.decode(response.body);
      return offersJson.map((json) => OfferModel.fromJson(json)).toList();
    } else if (response.statusCode == 401) {
      throw Exception("Unauthorized - Please login again");
    } else {
      throw Exception("Failed To Fetch Offers: ${response.statusCode}");
    }
  }

  Future<List<OfferModel>> fetchCategories() async {
    final headers = await _getAuthHeaders();
    final response = await http.get(
      Uri.parse('$baseUrl/categories'),
      headers: headers,
    );
    print(response.body);
    if (response.statusCode == 200) {
      final List<dynamic> categoriesJson = json.decode(response.body);
      return categoriesJson.map((json) => OfferModel.fromJson(json)).toList();
    } else if (response.statusCode == 401) {
      throw Exception("Unauthorized - Please login again");
    } else {
      throw Exception("Failed To Fetch Categories: ${response.statusCode}");
    }
  }

  Future<List<OfferModel>> fetchPlaces() async {
    final headers = await _getAuthHeaders();
    final response = await http.get(
      Uri.parse('$baseUrl/recommendedwilayas'),
      headers: headers,
    );
    print(response.body);
    if (response.statusCode == 200) {
      final List<dynamic> placesJson = json.decode(response.body);
      return placesJson.map((json) => OfferModel.fromJson(json)).toList();
    } else if (response.statusCode == 401) {
      throw Exception("Unauthorized - Please login again");
    } else {
      throw Exception("Failed To Fetch Places: ${response.statusCode}");
    }
  }

  Future<OfferModel> fetchOfferById(int id) async {
    final headers = await _getAuthHeaders();
    final response = await http.get(
      Uri.parse('$baseUrl/agency/getoffer/:${id}'),
      headers: headers,
    );
    print(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> offerJson = json.decode(response.body);
      return OfferModel.fromJson(offerJson);
    } else if (response.statusCode == 401) {
      throw Exception("Unauthorized - Please login again");
    } else {
      throw Exception("Failed To Fetch Offer: ${response.statusCode}");
    }
  }



Future<List<OfferModel>> fetchOffersByAgencyId(int agencyId) async {
    final headers = await _getAuthHeaders();
    final response = await http.get(
      Uri.parse('$baseUrl/agency/$agencyId/offers'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final List<dynamic> offersJson = json.decode(response.body);
      return offersJson.map((json) => OfferModel.fromJson(json)).toList();
    } else if (response.statusCode == 401) {
      throw Exception("Unauthorized - Please login again");
    } else {
      throw Exception("Failed To Fetch Offers: ${response.statusCode}");
    }
  }



  Future<void> addOffer(OfferModel offer, int agencyId) async {
    final headers = await _getAuthHeaders();
    final response = await http.post(
      Uri.parse('$baseUrl/agency/$agencyId/addOffer'),
      headers: headers,
      body: json.encode(offer.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add offer: ${response.statusCode}');
    }
  }
}
