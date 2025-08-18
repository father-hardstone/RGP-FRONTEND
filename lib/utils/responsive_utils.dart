import 'package:rgp_landing_take_3/constants/typography.dart';

class ResponsiveUtils {
  // Responsive breakpoints
  static const double threshold1 = 800.0;
  static const double threshold2 = 850.0;
  static const double threshold3 = 1400.0;

  // Calculate heading size based on screen width - now uses uniform typography
  static double calculateHeadingSize(double width, double height) {
    return TypographyConstants.getHeadingSize(width);
  }

  // Calculate services section height
  static double calculateServicesSectionHeight(double width, double height) {
    if (width < threshold3 && height < threshold2) {
      return 1210.0;
    } else if (width >= threshold3 && height < threshold2) {
      return 920.0;
    } else if (width < threshold3 && height >= threshold2) {
      return height;
    } else {
      return height;
    }
  }

  // Get top spacing for services section
  static double getTopSpacing(double width, double height) {
    if (width < threshold1) {
      return height * 0.09;
    } else {
      return height * 0.10;
    }
  }

  // Get middle spacing for services section
  static double getMiddleSpacing(double width, double height) {
    if (width < threshold1) {
      return height * 0.03;
    } else {
      return height * 0.09;
    }
  }

  // Check if screen is mobile
  static bool isMobile(double width) {
    return TypographyConstants.isMobile(width);
  }

  // Check if screen is tablet
  static bool isTablet(double width) {
    return TypographyConstants.isTablet(width);
  }

  // Check if screen is desktop
  static bool isDesktop(double width) {
    return TypographyConstants.isDesktop(width);
  }
}
