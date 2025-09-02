import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  // Backend API URL
  static String get backendApiUrl => kReleaseMode
      ? const String.fromEnvironment('BACKEND_API_URL', defaultValue: '')
      : dotenv.env['BACKEND_API_URL'] ?? '';

  // Enquiry endpoint
  static String get enquiryEndpoint => kReleaseMode
      ? const String.fromEnvironment('ENQUIRY_ENDPOINT', defaultValue: '')
      : dotenv.env['ENQUIRY_ENDPOINT'] ?? '';

  // Full URL
  static String get fullEnquiryUrl => '$backendApiUrl$enquiryEndpoint';

  // Social URLs
  static const String facebookUrl =
      'https://www.facebook.com/groups/fluttercommunity/';
  static const String linkedinUrl = 'https://www.linkedin.com/';
  static const String twitterUrl = 'https://www.twitter.com/';
}
