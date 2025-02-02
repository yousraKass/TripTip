// agency_repository.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:triptip/data/models/agency/agency_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      int id, String token) async {
    try {
    
      final response = await http.get(
        Uri.parse('$baseUrl/$id'),
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


}
