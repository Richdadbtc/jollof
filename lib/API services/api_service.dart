import 'dart:convert';  // To handle JSON data
import 'package:http/http.dart' as http;  // HTTP package for requests

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  // Method to perform a GET request
  Future<dynamic> getData(String endpoint) async {
    final url = Uri.parse('$baseUrl/$endpoint');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, we decode the JSON
        return json.decode(response.body);
      } else {
        // If the server returns a non-200 response, throw an exception
        throw Exception('Failed to load data');
      }
    } catch (e) {
      // Handle any errors that occur during the request
      throw Exception('Failed to fetch data: $e');
    }
  }

  // Method to perform a POST request
  Future<dynamic> postData(String endpoint, Map<String, dynamic> data) async {
    final url = Uri.parse('$baseUrl/$endpoint');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(data),  // Convert data map to JSON
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        // Decode the response body (if necessary)
        return json.decode(response.body);
      } else {
        throw Exception('Failed to post data');
      }
    } catch (e) {
      throw Exception('Failed to post data: $e');
    }
  }
}
