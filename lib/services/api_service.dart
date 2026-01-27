import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = 'http://16.176.158.130/api';
  static const String imageBaseUrl = 'http://16.176.158.130';

  static Future<Map<String, dynamic>?> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/AuthApi/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        if (result['success'] == true && result['data'] != null) {
          final data = result['data'];
          final prefs = await SharedPreferences.getInstance();
          await prefs.setInt('userId', data['id']);
          await prefs.setString('username', data['username']);
          await prefs.setString('role', data['role']);
          await prefs.setString('roleName', data['roleName']);
          return data;
        }
      }
    } catch (e) {
      print('Login error: $e');
    }
    return null;
  }

  static Future<bool> register(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/AuthApi/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );
      return response.statusCode == 200;
    } catch (e) {
      print('Register error: $e');
    }
    return false;
  }

  static Future<List<dynamic>> getShops() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/LaundryShopApi'));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print('Get shops error: $e');
    }
    return [];
  }

  static Future<List<dynamic>> getMyOrders() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('userId') ?? 0;
      final response = await http.get(Uri.parse('$baseUrl/OrderApi/my-orders/$userId'));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print('Get orders error: $e');
    }
    return [];
  }

  static Future<bool> createContact(Map<String, dynamic> data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('userId') ?? 0;
      data['customerId'] = userId;
      
      final response = await http.post(
        Uri.parse('$baseUrl/ContactApi'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
      return response.statusCode == 200;
    } catch (e) {
      print('Create contact error: $e');
    }
    return false;
  }
}
