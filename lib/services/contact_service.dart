import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ContactService {
  // Base URL for your backend API
  static const String _baseUrl = 'https://your-backend-api.com/api';
  
  // Endpoint for contact form submission
  static const String _contactEndpoint = '/contact';
  
  /// Contact form data model
  static Map<String, dynamic> _createContactPayload({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String company,
    required String queryType,
    required String query,
  }) {
    return {
      'firstName': firstName.trim(),
      'lastName': lastName.trim(),
      'email': email.trim(),
      'phone': phone.trim(),
      'company': company.trim(),
      'queryType': queryType,
      'query': query.trim(),
      'timestamp': DateTime.now().toIso8601String(),
      'source': 'rgp_landing_website',
    };
  }
  
  /// Submit contact form to backend
  static Future<Map<String, dynamic>> submitForm({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String company,
    required String queryType,
    required String query,
  }) async {
    try {
      // Create the request payload
      final payload = _createContactPayload(
        firstName: firstName,
        lastName: lastName,
        email: email,
        phone: phone,
        company: company,
        queryType: queryType,
        query: query,
      );
      
      // Make HTTP POST request to backend
      final response = await http.post(
        Uri.parse('$_baseUrl$_contactEndpoint'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // Add any authentication headers if needed
          // 'Authorization': 'Bearer $token',
        },
        body: jsonEncode(payload),
      ).timeout(
        const Duration(seconds: 30), // 30 second timeout
      );
      
      // Check if request was successful
      if (response.statusCode >= 200 && response.statusCode < 300) {
        // Success response
        final responseData = jsonDecode(response.body);
        return {
          'success': true,
          'message': responseData['message'] ?? 'Message sent successfully!',
          'data': responseData,
        };
      } else {
        // Error response from server
        final errorData = jsonDecode(response.body);
        return {
          'success': false,
          'message': errorData['message'] ?? 'Failed to send message',
          'error': 'HTTP ${response.statusCode}',
          'details': errorData,
        };
      }
    } on http.ClientException catch (e) {
      // Network/connection errors
      return {
        'success': false,
        'message': 'Network error: Unable to connect to server',
        'error': 'ClientException',
        'details': e.toString(),
      };
    } on SocketException catch (e) {
      // Socket/connection errors
      return {
        'success': false,
        'message': 'Connection error: Please check your internet connection',
        'error': 'SocketException',
        'details': e.toString(),
      };
    } catch (e) {
      // Any other unexpected errors
      return {
        'success': false,
        'message': 'An unexpected error occurred',
        'error': 'Unknown',
        'details': e.toString(),
      };
    }
  }
  
  /// Validate email format
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }
  
  /// Validate phone number format
  static bool isValidPhone(String phone) {
    // Allows digits, spaces, dashes, parentheses, and + at the beginning
    final phoneRegex = RegExp(r'^[\+]?[0-9\s\-\(\)]{7,20}$');
    return phoneRegex.hasMatch(phone);
  }
  
  /// Test connection to backend (useful for debugging)
  static Future<bool> testConnection() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/health'), // Assuming you have a health endpoint
        headers: {'Accept': 'application/json'},
      ).timeout(const Duration(seconds: 10));
      
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}

/// Contact form data model class (optional, for type safety)
class ContactFormData {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String company;
  final String queryType;
  final String query;
  
  const ContactFormData({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.company,
    required this.queryType,
    required this.query,
  });
  
  /// Convert to JSON map
  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'company': company,
      'queryType': queryType,
      'query': query,
    };
  }
  
  /// Create from JSON map
  factory ContactFormData.fromJson(Map<String, dynamic> json) {
    return ContactFormData(
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      company: json['company'] ?? '',
      queryType: json['queryType'] ?? '',
      query: json['query'] ?? '',
    );
  }
}
