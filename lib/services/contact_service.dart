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
    print('🔧 [DEBUG] ContactService.submitForm called');
    print('🔧 [DEBUG] Config values:');
    print('  - _baseUrl: $_baseUrl');
    print('  - _enquiryEndpoint: $_enquiryEndpoint');
    print('  - Full URL: $_baseUrl$_enquiryEndpoint');
    
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
      
      print('📦 [DEBUG] Created payload:');
      payload.forEach((key, value) {
        print('  - $key: $value');
      });
      
      // Make HTTP POST request to backend
      final jsonBody = jsonEncode(payload);
      
      // Debug: Print the request details
      print('🌐 [DEBUG] HTTP Request Details:');
      print('  - URL: $_baseUrl$_enquiryEndpoint');
      print('  - Method: POST');
      print('  - Headers: Content-Type: application/json, Accept: application/json, User-Agent: RGP-Landing-Form/1.0');
      print('  - Body: $jsonBody');
      print('  - Timeout: 30 seconds');
      
      final uri = Uri.parse('$_baseUrl$_enquiryEndpoint');
      print('🔗 [DEBUG] Parsed URI: $uri');
      print('🔗 [DEBUG] URI scheme: ${uri.scheme}');
      print('🔗 [DEBUG] URI host: ${uri.host}');
      print('🔗 [DEBUG] URI port: ${uri.port}');
      print('🔗 [DEBUG] URI path: ${uri.path}');
      
      final response = await http.post(
        uri,
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
      
      print('📡 [DEBUG] HTTP Response received:');
      print('  - Status Code: ${response.statusCode}');
      print('  - Reason Phrase: ${response.reasonPhrase}');
      print('  - Headers: ${response.headers}');
      print('  - Body: ${response.body}');
      
      // Check if request was successful
      if (response.statusCode >= 200 && response.statusCode < 300) {
        print('✅ [DEBUG] HTTP request successful (${response.statusCode})');
        // Success response
        try {
          final responseData = jsonDecode(response.body);
          print('📄 [DEBUG] Parsed response data: $responseData');
          return {
            'success': true,
            'message': responseData['message'] ?? 'Message sent successfully!',
            'data': responseData,
          };
        } catch (e) {
          print('⚠️ [DEBUG] Failed to parse success response JSON: $e');
          return {
            'success': true,
            'message': 'Message sent successfully!',
            'data': response.body,
          };
        }
      } else {
        print('❌ [DEBUG] HTTP request failed with status: ${response.statusCode}');
        print('❌ [DEBUG] Error response body: ${response.body}');
        print('❌ [DEBUG] Error response headers: ${response.headers}');
        
        try {
          final errorData = jsonDecode(response.body);
          print('📄 [DEBUG] Parsed error data: $errorData');
          return {
            'success': false,
            'message': errorData['message'] ?? 'Failed to send message',
            'error': 'HTTP ${response.statusCode}',
            'details': errorData,
          };
        } catch (e) {
          print('⚠️ [DEBUG] Failed to parse error response JSON: $e');
          return {
            'success': false,
            'message': 'Server error: ${response.statusCode}',
            'error': 'HTTP ${response.statusCode}',
            'details': response.body,
          };
        }
      }
    } on http.ClientException catch (e) {
      print('🌐 [DEBUG] ClientException caught:');
      print('  - Type: ${e.runtimeType}');
      print('  - Message: ${e.message}');
      print('  - Uri: ${e.uri}');
      print('  - Stack trace: ${StackTrace.current}');
      // Network/connection errors
      return {
        'success': false,
        'message': 'Network error: Unable to connect to server',
        'error': 'ClientException',
        'details': e.toString(),
      };
    } on SocketException catch (e) {
      print('🔌 [DEBUG] SocketException caught:');
      print('  - Type: ${e.runtimeType}');
      print('  - Message: ${e.message}');
      print('  - OS Error: ${e.osError}');
      print('  - Stack trace: ${StackTrace.current}');
      // Socket/connection errors
      return {
        'success': false,
        'message': 'Connection error: Please check your internet connection',
        'error': 'SocketException',
        'details': e.toString(),
      };
    } catch (e) {
      print('💥 [DEBUG] Unexpected exception caught:');
      print('  - Type: ${e.runtimeType}');
      print('  - Message: ${e.toString()}');
      print('  - Stack trace: ${StackTrace.current}');
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
