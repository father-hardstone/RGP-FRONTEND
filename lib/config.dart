class Config {
  // Backend configuration (can be updated later if needed)
  static const String backendApiUrl = 'http://localhost:5000';
  static const String enquiryEndpoint = '/enquiry';
  
  static String get fullEnquiryUrl {
    return '$backendApiUrl$enquiryEndpoint';
  }
  
  // Social media URLs (can be updated later)
  static const String facebookUrl = 'https://www.facebook.com/groups/fluttercommunity/';
  static const String linkedinUrl = 'https://www.linkedin.com/';
  static const String twitterUrl = 'https://www.twitter.com/';
}



