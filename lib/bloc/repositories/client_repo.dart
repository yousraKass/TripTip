import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:triptip/bloc/models/client_model.dart';

class ClientRepository {
  final String baseUrl = 'http://localhost:3000/TripTip/client';

  Future<ClientModel> signUp(ClientModel client) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/signup'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(client.toJson()),
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

  Future<ClientModel> fetchUserData(
      int id, String token, String role) async {
    try {
    
      final response = await http.get(
        Uri.parse('$baseUrl/login/$role/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body);
        return ClientModel.fromJson(data);
      } else {
        throw Exception('Failed to fetch user data');
      }
    } catch (e) {
      throw Exception('Failed to fetch user profile: $e');
    }
  }

   // Fetch client profile 
  Future<ClientModel> fetchClientProfile() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/profile/info:1'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return ClientModel.fromJson(data);
      } else {
        throw Exception('Failed to load client profile: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }

  // Update client profile  
  Future<void> updateClientProfile(ClientModel profile) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/profile/editinfo'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(profile.toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update client profile: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }
}
