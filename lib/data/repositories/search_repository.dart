import 'package:dio/dio.dart';
import '/data/models/OfferModel.dart';

class SearchRepository {
  final Dio _dio;
  
  SearchRepository({Dio? dio}) : _dio = dio ?? Dio();

  Future<List<OfferModel>> searchOffers({
    required String query,
    String? rankBy,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final response = await _dio.get(
        '/api/offers/search',
        queryParameters: {
          'query': query,
          'rankBy': rankBy,
          if (filters != null) ...filters,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['offers'];
        return data.map((json) => OfferModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to search offers');
      }
    } catch (e) {
      throw Exception('Failed to search offers: $e');
    }
  }

  Future<List<String>> getSuggestions() async {
    try {
      final response = await _dio.get('/api/suggestions');
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['suggestions'];
        return data.map((json) => json.toString()).toList();
      } else {
        throw Exception('Failed to get suggestions');
      }
    } catch (e) {
      throw Exception('Failed to get suggestions: $e');
    }
  }
}