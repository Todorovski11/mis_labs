import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://official-joke-api.appspot.com';

  // Fetch all joke types
  Future<List<String>> fetchJokeTypes() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/types'));
      if (response.statusCode == 200) {
        return List<String>.from(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load joke types');
      }
    } catch (e) {
      throw Exception('Error fetching joke types: $e');
    }
  }

  // Fetch jokes of a specific type
  Future<List<Map<String, dynamic>>> fetchJokesByType(String type) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/jokes/$type/ten'));
      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load jokes for type: $type');
      }
    } catch (e) {
      throw Exception('Error fetching jokes by type: $e');
    }
  }

  // Fetch a random joke
  Future<Map<String, dynamic>> fetchRandomJoke() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/random_joke'));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load random joke');
      }
    } catch (e) {
      throw Exception('Error fetching random joke: $e');
    }
  }

  // Fetch a single joke by its ID (optional)
  Future<Map<String, dynamic>> fetchJokeById(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/jokes/$id'));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load joke with ID: $id');
      }
    } catch (e) {
      throw Exception('Error fetching joke by ID: $e');
    }
  }
}
