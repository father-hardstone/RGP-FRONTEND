import 'package:flutter/material.dart';

class ScrollControllerHelper {
  // Page lengths for different sections
  double pl1 = 0; // Hero section length
  double pl2 = 0; // Services section length
  double pl3 = 0; // Why choose us section length
  double pl4 = 0; // About us section length
  double pl5 = 0; // Contact section length
  double pl6 = 0; // Additional section length
  
  // Reference to the landing page for safe scrolling
  dynamic _landingPage;

  void initializeScrollController(ScrollController controller) {
    controller.addListener(() {
      // Add any scroll listener logic here if needed
    });
  }
  
  void setLandingPage(dynamic landingPage) {
    _landingPage = landingPage;
  }

  // Calculate page lengths based on screen dimensions
  void calculatePageLengths(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    // Responsive breakpoints
    const threshold1 = 800.0;
    const threshold2 = 850.0;
    const threshold3 = 1400.0;

    // Hero section
    if (width < threshold1) {
      pl1 = 600;
    } else if (width < threshold3 && height < threshold2) {
      pl1 = 950;
    } else if (width >= threshold3 && height < threshold2) {
      pl1 = 920;
    } else {
      pl1 = 0.92 * height;
    }

    // Services section
    if (width < threshold1) {
      pl2 = 1430;
    } else if (width < threshold3 && height < threshold2) {
      pl2 = 1210;
    } else if (width >= threshold3 && height < threshold2) {
      pl2 = 920;
    } else {
      pl2 = height;
    }

    // Why choose us section
    if (width < threshold3 && height < threshold2) {
      pl3 = 600;
    } else if (width >= threshold3 && height < threshold2) {
      pl3 = 650;
    } else {
      pl3 = 0.7 * height;
    }

    // About us section
    if (width < threshold3 && height < threshold2) {
      pl4 = 1000;
    } else if (width >= threshold3 && height < threshold2) {
      pl4 = 950;
    } else {
      pl4 = 0.92 * height;
    }

    // Contact section
    pl5 = 0.8 * height;
    pl6 = height;

    // Debug output
    print('Page lengths calculated:');
    print('Screen: ${width}x${height}');
    print('Hero (pl1): $pl1');
    print('Services (pl2): $pl2');
    print('Why Choose Us (pl3): $pl3');
    print('About Us (pl4): $pl4');
    print('Contact (pl5): $pl5');
  }

  // Scroll to specific section
  void scrollToSection(ScrollController controller, int sectionIndex) {
    double offset = 0;
    switch (sectionIndex) {
      case 1: // About Us
        // Use the precise About Us section position for perfect alignment
        // Based on terminal output showing About Us at ~2312px
        // pl1 + pl2 + pl3 = 877.68 + 954 + 667.8 = 2499.48
        // Target: 2312px, so we need: 2499.48 - 187.48 = 2312
        offset = pl1 + pl2 + pl3 - 187; // Precise offset to reach 2312px
        break;
      case 2: // Contact Us
        offset = pl1 + pl2 + pl3 + pl4 + pl5 + 20;
        break;
      case 3: // Learn More (Our Services section)
        // Use the precise services section position for perfect alignment
        // Based on terminal output showing services at ~956px
        offset = pl1 + 80; // Add small offset to account for any spacing/margins
        break;
    }

    // Debug output
    print('Scrolling to section $sectionIndex');
    print('Page lengths: pl1=$pl1, pl2=$pl2, pl3=$pl3, pl4=$pl4, pl5=$pl5');
    print('Calculated offset: $offset');
    print('Current scroll position: ${controller.offset}');
    print('Max scroll extent: ${controller.position.maxScrollExtent}');

    // Use safe scrolling if available, otherwise fall back to standard
    if (_landingPage != null && _landingPage.safeScrollTo != null) {
      print('Using safe scroll method');
      _landingPage.safeScrollTo(offset);
    } else {
      print('Using standard scroll method');
      controller.animateTo(
        offset,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeInOut,
      );
    }
  }
}
