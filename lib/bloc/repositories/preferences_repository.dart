import 'package:triptip/bloc/models/preferences_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PreferencesRepository {
  final String baseUrl =
      'http://localhost:3030/TripTip/client/profile'; // Replace with your actual API URL

  Future<List<Preference>> getUserPreferences() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/preferences'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        
        return data
            .map((json) => Preference.fromJson(json))
            .where((preference) => preference.selected)
            .toList();
      } else {
        throw Exception('Failed to load preferences: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }

  Future<void> updateUserPreference(Preference preference) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/editprefrences'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(preference.toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update preference: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }

}
