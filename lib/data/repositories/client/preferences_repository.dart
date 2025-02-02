import 'package:triptip/data/models/client/preferences_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PreferencesRepository {
  final String baseUrl =
      'http://localhost:3030/TripTip/client/profile'; 

  // Fetch user preferences
  Future<List<Preference>> getUserPreferences(String clientId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/preferences:$clientId'), // Include clientId in the URL
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        
        // Parse the response into a list of Preference objects
        return data.map((json) => Preference.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load preferences: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }

  // Update user preferences
 /*  Future<void> updateUserPreferences(String clientId, List<int> preferenceIds) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/editprefrences:$clientId'), // Include clientId in the URL
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'preferences': preferenceIds, // Send a list of preference IDs
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update preferences: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  } */
 Future<void> updateUserPreferences(int preferenceId, bool selected) async {
  try {
    final response = await http.put(
      Uri.parse('$baseUrl/editprefrences'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'id': preferenceId,
        'selected': selected,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update preference: ${response.body}');
    }
  } catch (e) {
    throw Exception('Failed to connect to the server: $e');
  }
}
}


/* import 'package:triptip/data/models/client/preferences_model.dart';
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
 */