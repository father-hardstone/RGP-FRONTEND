import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:rgp_landing_take_3/components/sections/contact_text_section.dart';
import 'package:rgp_landing_take_3/components/sections/contact_form_section.dart';
import 'package:rgp_landing_take_3/constants/typography.dart';
import 'package:rgp_landing_take_3/constants/responsive_breakpoints.dart';

class ContactSection extends StatefulWidget {
  final ScrollController? scrollController;

  const ContactSection({
    super.key,
    this.scrollController,
  });

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> with TickerProviderStateMixin {
  late AnimationController _gradientController;
  bool _animationsInitialized = false;

  @override
  void initState() {
    super.initState();
    
    // Initialize gradient controller for northern lights effect
    _gradientController = AnimationController(
      duration: const Duration(seconds: 8), // 8-second sweep
      vsync: this,
    )..repeat(); // Continuous northern lights effect
    
    _animationsInitialized = true;
  }

  @override
  void dispose() {
    _gradientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return LayoutBuilder(
            builder: (context, constraints) {
              final double width = constraints.maxWidth;
              final double height = MediaQuery.of(context).size.height;
              
              // Responsive breakpoints
              final bool isMobile = ResponsiveBreakpoints.isMobile(width);
              final bool isTablet = ResponsiveBreakpoints.isTablet(width);
              final bool isDesktop = ResponsiveBreakpoints.isDesktop(width);
              
              // Calculate responsive dimensions
              final double sectionHeight = _calculateSectionHeight(width, height, isMobile);
              final double textSize = _calculateTextSize(width, isMobile);
              final double headingSize = _calculateHeadingSize(width, isMobile);

              return Container(
                width: width,
                height: sectionHeight,
                child: Column(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          // Background with northern lights effect
                          Positioned.fill(
                            child: _animationsInitialized 
                              ? AnimatedBuilder(
                                  animation: _gradientController,
                                  builder: (context, child) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Color(0xFF143877).withOpacity(0.35), // Blue at top
                                            Color(0xFF1A4A8F).withOpacity(0.45), // Lighter blue in middle
                                            Color(0xFF143877).withOpacity(0.35), // Blue
                                            Color(0xFF143877).withOpacity(0.2), // Fading out
                                            Color(0xFF143877).withOpacity(0.1), // More faded
                                            Colors.transparent, // Completely transparent at bottom
                                          ],
                                          stops: [0.0, 0.3, 0.6, 0.8, 0.9, 1.0],
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color(0xFF143877).withOpacity(0.4), // Blue at top
                                        Color(0xFF143877).withOpacity(0.3), // Fading
                                        Color(0xFF143877).withOpacity(0.2), // More faded
                                        Color(0xFF143877).withOpacity(0.1), // Very faded
                                        Colors.transparent, // Completely transparent at bottom
                                      ],
                                      stops: [0.0, 0.4, 0.7, 0.9, 1.0],
                                    ),
                                  ),
                                ),
                          ),
                          
                          // Content on top of the northern lights
                          isMobile || isTablet
                              ? _buildMobileLayout(width, sectionHeight, textSize, headingSize)
                              : _buildDesktopLayout(width, sectionHeight, textSize, headingSize),
                        ],
                      ),
                    ),
                    
                    // Divider line
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 40),
                      height: 1,
                      color: Colors.white.withOpacity(0.3),
                    ),
                    
                    // Copyright text
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                      child: Text(
                        '© 2024 RGP IT Solutions. All rights reserved.',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        childCount: 1,
      ),
    );
  }

  Widget _buildMobileLayout(double width, double height, double textSize, double headingSize) {
    return Column(
      children: [
        // Text section - 40% height
        Expanded(
          flex: 2,
          child: ContactTextSection(
            textSize: textSize,
            headingSize: headingSize,
            isMobile: true,
          ),
        ),
        // Form section - 60% height
        Expanded(
          flex: 3, // 3:2 ratio gives 60% to form, 40% to text
          child: ContactFormSection(
            textSize: textSize,
            isMobile: true,
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(double width, double height, double textSize, double headingSize) {
    return Row(
      children: [
        // Text section (50% width)
        Expanded(
          flex: 1,
          child: ContactTextSection(
            textSize: textSize,
            headingSize: headingSize,
            isMobile: false,
          ),
        ),
        // Form section (50% width)
        Expanded(
          flex: 1,
          child: ContactFormSection(
            textSize: textSize,
            isMobile: false,
          ),
        ),
      ],
    );
  }

  double _calculateSectionHeight(double width, double height, bool isMobile) {
    if (width < 600) {
      return height * 1.85; // Small mobile: adjusted height to prevent overflow
    } else if (width < 800) {
      return height * 1.8; // Tablet: increased height for better proportions
    } else if (width < 1200) {
      return height * 0.85; // Small desktop: slight height increase
    } else {
      return height * 0.9; // Large desktop: moderate height
    }
  }

  double _calculateTextSize(double width, bool isMobile) {
    if (width < 800) {
      return width * 0.035; // Mobile/Tablet: adjusted text size
    } else {
      return width * 0.015; // Desktop: larger text
    }
  }

  double _calculateHeadingSize(double width, bool isMobile) {
    if (width < 800) {
      return width * 0.06; // Mobile/Tablet: adjusted heading size
    } else {
      return width * 0.025; // Desktop: smaller heading
    }
  }
}
