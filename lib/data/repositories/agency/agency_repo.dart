// agency_repository.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:triptip/data/models/agency/agency_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:triptip/data/models/OfferModel.dart';


class AgencyRepository {
  final String baseUrl = 'http://localhost:3000/TripTip';

  Future<AgencyModel> signUpAgency(AgencyModel agency) async {
  try {
    final response = await http.post(
      Uri.parse('$baseUrl/agency/signup'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(agency.toJson()),
    );

    if (response.statusCode == 201) { // Note: Your Go backend returns 201 for creation
      final dynamic data = json.decode(response.body);
      final token = data['token'];
      final id = data['id']; // Changed from 'user_id' to 'id' to match Go response
      final role = data['user_type'];

      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('user_id', id);
      await prefs.setString('user_token', token);
      await prefs.setString('user_role', role);

      return await fetchAgencyData(id, token);
    } else {
      throw Exception('Failed to sign up: ${response.body}');
    }
  } catch (e) {
    throw Exception('Failed to connect to the server: $e');
  }
}

  //for login
  Future<AgencyModel> loginAgency({
    required String email,
    required String password,
  }) async {
    try {
      // Adjust the login endpoint based on the role
      final loginResponse = await http.post(
        Uri.parse('$baseUrl/agency/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      if (loginResponse.statusCode == 200) {
        final data = json.decode(loginResponse.body);

        // If the API returns a token, fetch user data securely
        final token = data['token'];
        final id = data['user_id'];
        final role = data['user_type'];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt('user_id', id);
        await prefs.setString('user_token', token);
        await prefs.setString('user_role', role);

        return await fetchAgencyData(id, token);
      } else if (loginResponse.statusCode == 401) {
        throw Exception('Invalid credentials');
      } else {
        throw Exception('Login failed: ${loginResponse.body}');
      }
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  Future<AgencyModel> fetchAgencyData(
    int id,
    String token,
  ) async {
    print('fetching user data');
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/agency/myprofile/$id'),
         headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      );

      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body);
        return AgencyModel.fromJson(data);
      } else {
        throw Exception('Failed to fetch user data');
      }
    } catch (e) {
      throw Exception('Failed to fetch user profile: $e');
    }
  }


    Future<AgencyModel> fetchPublicAgencyData(int id) async {
  try {
    print('Attempting to fetch agency data for ID: $id'); // Debug log
    final response = await http.get(
      Uri.parse('$baseUrl/agency/myprofile/$id'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    print('Response status: ${response.statusCode}'); // Debug log
    print('Response body: ${response.body}'); // Debug log

    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);
      return AgencyModel.fromJson(data);
    } else {
      throw Exception('Failed to fetch agency data: Status ${response.statusCode}');
    }
  } catch (e) {
    print('Error details: $e'); // Debug log
    throw Exception('Failed to fetch agency profile: $e');
  }
}

  Future<AgencyModel> editAgencyProfile(
      AgencyModel agency, String token) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/${agency.id}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(agency.toJson()),
      );

      if (response.statusCode == 200) {
        return AgencyModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to edit profile: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }



//for forget password
  // Send reset code
  Future<void> sendResetCode(String email) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/send-reset-code'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email}),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to send reset code: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }

  // Verify reset code
  Future<void> verifyResetCode(String email, String code) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/verify-reset-code'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'code': code}),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to verify reset code: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }

  // Update password
  Future<void> updatePassword(String email, String newPassword) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/update-password'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'newPassword': newPassword}),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update password: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }
}
