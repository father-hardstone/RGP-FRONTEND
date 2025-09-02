import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  // Backend configuration from environment variables
  static String get backendApiUrl => dotenv.env['BACKEND_API_URL']!;
  static String get enquiryEndpoint => dotenv.env['ENQUIRY_ENDPOINT']!;
  
  static String get fullEnquiryUrl {
    return '$backendApiUrl$enquiryEndpoint';
  }
  
  // Social media URLs (can be updated later)
  static const String facebookUrl = 'https://www.facebook.com/groups/fluttercommunity/';
  static const String linkedinUrl = 'https://www.linkedin.com/';
  static const String twitterUrl = 'https://www.twitter.com/';
}



