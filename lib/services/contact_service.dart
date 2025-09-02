import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:rgp_landing_take_3/config.dart';

class ContactService {
  // Use config for API URL and endpoint
  static String get _baseUrl => Config.backendApiUrl;
  static String get _enquiryEndpoint => Config.enquiryEndpoint;
  
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
      'first_name': firstName.trim(),
      'last_name': lastName.trim(),
      'email': email.trim(),
      'phone_number': phone.trim(),
      'company_name': company.trim(),
      'enquiry_type': queryType,
      'message': query.trim(),
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
      final jsonBody = jsonEncode(payload);
      
      // Debug: Print the request details
      print('Sending POST request to: $_baseUrl$_enquiryEndpoint');
      print('Headers: Content-Type: application/json');
      print('Body: $jsonBody');
      
      final response = await http.post(
        Uri.parse('$_baseUrl$_enquiryEndpoint'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'User-Agent': 'RGP-Landing-Form/1.0',
          // Add any authentication headers if needed
          // 'Authorization': 'Bearer $token',
        },
        body: jsonBody,
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
        print('Error response: ${response.statusCode}');
        print('Response body: ${response.body}');
        print('Response headers: ${response.headers}');
        
        try {
          final errorData = jsonDecode(response.body);
          return {
            'success': false,
            'message': errorData['message'] ?? 'Failed to send message',
            'error': 'HTTP ${response.statusCode}',
            'details': errorData,
          };
        } catch (e) {
          return {
            'success': false,
            'message': 'Server error: ${response.statusCode}',
            'error': 'HTTP ${response.statusCode}',
            'details': response.body,
          };
        }
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
  
  /// Test the enquiry endpoint with a simple request
  static Future<Map<String, dynamic>> testEnquiryEndpoint() async {
    try {
      final testPayload = {
        'first_name': 'Test',
        'last_name': 'User',
        'email': 'test@example.com',
        'phone_number': '+92 331 4554 742',
        'company_name': 'Test Company',
        'enquiry_type': 'General Inquiry',
        'message': 'This is a test message',
      };
      
      final jsonBody = jsonEncode(testPayload);
      print('Testing enquiry endpoint: $_baseUrl$_enquiryEndpoint');
      print('Test payload: $jsonBody');
      
      final response = await http.post(
        Uri.parse('$_baseUrl$_enquiryEndpoint'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'Accept': 'application/json',
          'User-Agent': 'RGP-Landing-Form/1.0',
        },
        body: jsonBody,
      ).timeout(const Duration(seconds: 10));
      
      print('Test response status: ${response.statusCode}');
      print('Test response body: ${response.body}');
      print('Test response headers: ${response.headers}');
      
      return {
        'success': response.statusCode >= 200 && response.statusCode < 300,
        'statusCode': response.statusCode,
        'body': response.body,
        'headers': response.headers,
      };
    } catch (e) {
      print('Test error: $e');
      return {
        'success': false,
        'error': e.toString(),
      };
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
