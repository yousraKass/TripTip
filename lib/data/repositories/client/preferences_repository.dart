import 'package:triptip/data/models/client/preferences_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class PreferencesRepository {
  final String baseUrl = 'http://localhost:3000/TripTip/client/profile';

  Future<List<Preference>> getUserPreferences(int clientId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/preferences:$clientId'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Preference.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load preferences: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }

  Future<void> updateUserPreferences(List<int> selectedPreferenceIds) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/editprefrences'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'selected_preference_ids': selectedPreferenceIds, // Send only the IDs of selected preferences
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update preferences: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }
}
