import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  static String get backendApiUrl {
    return dotenv.env['BACKEND_API_URL'] ?? 'http://localhost:5000';
  }
  
  static String get enquiryEndpoint {
    return dotenv.env['ENQUIRY_ENDPOINT'] ?? '/enquiry';
  }
  
  static String get fullEnquiryUrl {
    return '$backendApiUrl$enquiryEndpoint';
  }
  
  // Social media URLs (can be updated later)
  static const String facebookUrl = 'https://www.facebook.com/groups/fluttercommunity/';
  static const String linkedinUrl = 'https://www.linkedin.com/';
  static const String twitterUrl = 'https://www.twitter.com/';
}



