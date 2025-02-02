// agency_repository.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:triptip/data/models/agency/agency_model.dart';


class AgencyRepository {
  final String baseUrl =
      'http://localhost:3000/TripTip'; 

  Future<AgencyModel> signUpAgency(AgencyModel agency) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/agency/signup'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(agency.toJson()),
      );

      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body);
        return AgencyModel.fromJson(data);
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
        Uri.parse('$baseUrl/agency'),
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
        final id = data['id'];
        final role = data['role'];

        return await fetchUserData(id, token, role);
      } else if (loginResponse.statusCode == 401) {
        throw Exception('Invalid credentials');
      } else {
        throw Exception('Login failed: ${loginResponse.body}');
      }
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  Future<AgencyModel> fetchUserData(
      int id, String token, String role) async {
    try {
    
      final response = await http.get(
        Uri.parse('$baseUrl/$role/$id'),
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
