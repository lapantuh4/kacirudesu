import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Ganti IP sesuai perangkat yang kamu pakai untuk running Flutter
  static const String baseUrl = 'https://fading-situated-sermon.ngrok-free.dev/api';

  // Fungsi Register
  static Future<Map<String, dynamic>> register(
      String name, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
      }),
    );

    return jsonDecode(response.body);
  }

  // Fungsi Login
  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );
    print("Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");
    return jsonDecode(response.body);
  }

}