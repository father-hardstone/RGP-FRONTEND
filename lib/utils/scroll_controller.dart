import 'package:flutter/material.dart';

class ScrollControllerHelper {
  // Page lengths for different sections
  double pl1 = 0; // Hero section length
  double pl2 = 0; // Services section length
  double pl3 = 0; // Why choose us section length
  double pl4 = 0; // About us section length
  double pl5 = 0; // Contact section length
  double pl6 = 0; // Additional section length

  void initializeScrollController(ScrollController controller) {
    controller.addListener(() {
      // Add any scroll listener logic here if needed
    });
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
    if (width < threshold1) {
      pl3 = 1200;
    } else if (width < threshold3 && height < threshold2) {
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
  }

  // Scroll to specific section
  void scrollToSection(ScrollController controller, int sectionIndex) {
    double offset = 0;
    switch (sectionIndex) {
      case 1: // About Us
        offset = pl1 + pl2 + pl3 + 10;
        break;
      case 2: // Contact Us
        offset = pl1 + pl2 + pl3 + pl4 + pl5 + 20;
        break;
      case 3: // Learn More (next section)
        offset = pl1 + 45;
        break;
    }

    controller.animateTo(
      offset,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
    );
  }
}
