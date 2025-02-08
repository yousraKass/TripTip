import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:triptip/data/models/client/client_model.dart';

class ClientRepository {
  final String baseUrl = 'http://localhost:3000/TripTip/client';

  Future<ClientModel> signUp(ClientModel client) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/signup'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(client.toJsonForAuth()),
      );

      if (response.statusCode == 201) {
        final dynamic data = json.decode(response.body);
        return ClientModel.fromJson(data);
      } else {
        throw Exception('Failed to sign up: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }

  //for login
  Future<ClientModel> loginClient({
    required String email,
    required String password,
  }) async {
    try {
      // Adjust the login endpoint based on the role
      final loginResponse = await http.post(
        Uri.parse('$baseUrl/login'),
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

        print('Logged in user ID: $id'); // Print the id

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

  Future<ClientModel> fetchUserData(int id, String token, String role) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/profile/info:$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        print("r1");
        final dynamic data = json.decode(response.body);
        print("r2");
        print(data);
        return ClientModel.fromJson(data);
      } else {
        throw Exception('Failed to fetch user data');
      }
    } catch (e) {
      throw Exception('Failed to fetch user profile: $e');
    }
  }


  Future<ClientModel> fetchClientProfile(int clientId) async {
    try {
      print('Fetching profile for clientId: $clientId'); // Debug log
      final response = await http.get(
        Uri.parse('$baseUrl/profile/info:$clientId'),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 10));

      print('Response status code: ${response.statusCode}'); // Debug log
      print('Response body: ${response.body}'); // Debug log

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Parsed JSON data: $data'); // Debug log
        return ClientModel.fromJson(data);
      } else if (response.statusCode == 404) {
        throw Exception('Client profile not found');
      } else {
        throw Exception(
            'Failed to load client profile: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching client profile: $e'); // Debug log
      throw Exception('Failed to connect to the server: $e');
    }
  }

// Update client profile
  Future<void> updateClientProfile(ClientModel profile) async {
    try {
      final response = await http
          .put(
            Uri.parse('$baseUrl/profile/editinfo'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode(profile.toJsonForEditInfo()),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        print('Profile updated successfully');
      } else if (response.statusCode == 400) {
        throw Exception('Bad request: ${response.body}');
      } else if (response.statusCode == 404) {
        throw Exception('Client profile not found');
      } else {
        throw Exception(
            'Failed to update client profile: ${response.statusCode}');
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
