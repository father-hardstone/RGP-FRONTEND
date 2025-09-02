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
    const mobileThreshold = 600.0;
    const tabletThreshold = 1024.0;
    const desktopThreshold = 1400.0;

    // Mobile screens (width < 600)
    if (width < mobileThreshold) {
      pl1 = height * 0.9; // Hero section - full screen
      pl2 = height * 1.2; // Services section - slightly taller
      pl3 = height * 0.8; // Why choose us section
      pl4 = height * 1.1; // About us section
      pl5 = height * 0.9; // Contact section
    }
    // Tablet screens (600 <= width < 1024)
    else if (width < tabletThreshold) {
      pl1 = height * 0.9; // Hero section
      pl2 = height * 1.0; // Services section
      pl3 = height * 0.7; // Why choose us section
      pl4 = height * 1.0; // About us section
      pl5 = height * 0.9; // Contact section
    }
    // Desktop screens (width >= 1024)
    else {
      pl1 = height * 0.9; // Hero section
      pl2 = height * 1.0; // Services section
      pl3 = height * 0.7; // Why choose us section
      pl4 = height * 0.9; // About us section
      pl5 = height * 0.8; // Contact section
    }

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
    // Ensure page lengths are calculated
    if (pl1 == 0 && _landingPage?.context != null) {
      calculatePageLengths(_landingPage.context);
    }
    
    // Get the calculated offset
    double offset = 0;
    final context = _landingPage?.context;
    if (context != null) {
      final size = MediaQuery.of(context).size;
      final screenHeight = size.height;
      final screenWidth = size.width;
      
      // Calculate responsive offset based on screen size
      double responsiveOffset;
      if (screenWidth < 600) {
        // Mobile - smaller offset
        responsiveOffset = screenHeight * 0.05;
      } else if (screenWidth < 1024) {
        // Tablet - medium offset
        responsiveOffset = screenHeight * 0.08;
      } else {
        // Desktop - larger offset
        responsiveOffset = screenHeight * 0.1;
      }
      
      switch (sectionIndex) {
        case 1: // About Us
          offset = pl1 + pl2 + pl3 - responsiveOffset;
          break;
        case 2: // Contact Us
          // Hardcoded positions for mobile and tablet screens
          if (screenWidth < 600) {
            offset = 4580.485; // Exact position for mobile Contact section
          } else if (screenWidth < 1024) {
            offset = 3542.48; // Exact position for tablet Contact section
          } else {
            // For Contact Us, we want to show the full contact section
            offset = pl1 + pl2 + pl3 + pl4 - (responsiveOffset * 0.5);
          }
          break;
        case 3: // Learn More (Our Services section)
          offset = pl1 + (responsiveOffset * 0.3);
          break;
      }
    } else {
      // Fallback calculation
      switch (sectionIndex) {
        case 1: // About Us
          offset = pl1 + pl2 + pl3 - 100;
          break;
        case 2: // Contact Us
          // Use hardcoded positions for mobile and tablet in fallback too
          offset = 3542.48; // Default to tablet position in fallback
          break;
        case 3: // Learn More (Our Services section)
          offset = pl1 + 50;
          break;
      }
    }

    // Ensure offset is within bounds
    final maxScrollExtent = controller.position.maxScrollExtent;
    if (offset > maxScrollExtent) {
      offset = maxScrollExtent;
    }
    if (offset < 0) {
      offset = 0;
    }

    // Debug output
    print('Scrolling to section $sectionIndex');
    print('Page lengths: pl1=$pl1, pl2=$pl2, pl3=$pl3, pl4=$pl4, pl5=$pl5');
    print('Calculated offset: $offset');
    print('Current scroll position: ${controller.offset}');
    print('Max scroll extent: $maxScrollExtent');

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

  // Dynamic section positioning with better calculations
  void scrollToSectionDynamic(ScrollController controller, int sectionIndex) {
    double offset = 0;
    
    // Get current screen dimensions for better positioning
    final context = _landingPage?.context;
    if (context != null) {
      final size = MediaQuery.of(context).size;
      final screenHeight = size.height;
      
      // Calculate responsive offsets based on screen size
      final double responsiveOffset = screenHeight * 0.1; // 10% of screen height
      
      switch (sectionIndex) {
        case 1: // About Us
          // Dynamic calculation with responsive offset
          offset = pl1 + pl2 + pl3 - responsiveOffset;
          break;
        case 2: // Contact Us
          // Dynamic calculation with responsive offset
          offset = pl1 + pl2 + pl3 + pl4 - responsiveOffset;
          break;
        case 3: // Learn More (Our Services section)
          // Dynamic calculation with responsive offset
          offset = pl1 + (responsiveOffset * 0.5); // Smaller offset for services
          break;
      }
    } else {
      // Fallback to static calculation if context not available
      switch (sectionIndex) {
        case 1: // About Us
          offset = pl1 + pl2 + pl3 - 100;
          break;
        case 2: // Contact Us
          offset = pl1 + pl2 + pl3 + pl4 - 100;
          break;
        case 3: // Learn More (Our Services section)
          offset = pl1 + 50;
          break;
      }
    }
  }
}
