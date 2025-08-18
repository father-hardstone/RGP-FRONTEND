import 'package:flutter/material.dart';

class TypographyConstants {
  // Main heading sizes (used for section titles like "Why Choose Us", "About Us", etc.)
  static const double headingLarge = 48.0;    // Desktop
  static const double headingMedium = 42.0;   // Tablet
  static const double headingSmall = 38.0;    // Mobile
  
  // Subheading sizes (used for secondary titles under main headings)
  static const double subheadingLarge = 32.0;  // Desktop
  static const double subheadingMedium = 28.0; // Tablet
  static const double subheadingSmall = 24.0;  // Mobile
  
  // Body text sizes (used for paragraphs and descriptions)
  static const double bodyLarge = 20.0;     // Desktop
  static const double bodyMedium = 18.0;    // Tablet
  static const double bodySmall = 16.0;     // Mobile
  
  // Small text sizes (used for captions, labels, etc.)
  static const double captionLarge = 16.0;   // Desktop
  static const double captionMedium = 14.0;  // Tablet
  static const double captionSmall = 12.0;   // Mobile
  
  // Number sizes (used for statistics like "5", "25+", etc.)
  static const double numberLarge = 72.0;    // Desktop
  static const double numberMedium = 64.0;   // Tablet
  static const double numberSmall = 56.0;    // Mobile
  
  // Get responsive font sizes based on screen width
  static double getResponsiveFontSize({
    required double width,
    required double largeSize,
    required double mediumSize,
    required double smallSize,
  }) {
    if (width >= 1200) {
      return largeSize;    // Desktop
    } else if (width >= 768) {
      return mediumSize;   // Tablet
    } else {
      return smallSize;    // Mobile
    }
  }
  
  // Convenience methods for common font sizes
  static double getHeadingSize(double width) {
    return getResponsiveFontSize(
      width: width,
      largeSize: headingLarge,
      mediumSize: headingMedium,
      smallSize: headingSmall,
    );
  }
  
  static double getSubheadingSize(double width) {
    return getResponsiveFontSize(
      width: width,
      largeSize: subheadingLarge,
      mediumSize: subheadingMedium,
      smallSize: subheadingSmall,
    );
  }
  
  static double getBodySize(double width) {
    return getResponsiveFontSize(
      width: width,
      largeSize: bodyLarge,
      mediumSize: bodyMedium,
      smallSize: bodySmall,
    );
  }
  
  static double getNumberSize(double width) {
    return getResponsiveFontSize(
      width: width,
      largeSize: numberLarge,
      mediumSize: numberMedium,
      smallSize: numberSmall,
    );
  }
  
  // Check if screen is mobile/tablet/desktop
  static bool isMobile(double width) => width < 768;
  static bool isTablet(double width) => width >= 768 && width < 1200;
  static bool isDesktop(double width) => width >= 1200;
}
